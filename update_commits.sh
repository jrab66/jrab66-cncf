#!/bin/bash

# Check if zenity is installed
if ! command -v zenity &> /dev/null; then
    echo "Error: zenity is required but not installed. Please install it with:"
    echo "sudo apt-get install zenity  # For Debian/Ubuntu"
    echo "or"
    echo "sudo dnf install zenity      # For Fedora/RHEL"
    exit 1
fi

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Error: git is required but not installed."
    exit 1
fi

# Check if there are any commits
if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
    zenity --error --text="No commits found in this repository."
    exit 1
fi

# Function to update commits with new date
update_commits_date() {
    local commit_hashes=("$@")
    
    # Show date picker dialog once for all commits
    selected_date=$(zenity --calendar \
        --title="Select New Date for All Selected Commits" \
        --text="Select the new date for all selected commits" \
        --date-format="%Y-%m-%d")

    # Check if user cancelled
    if [ $? -ne 0 ] || [ -z "$selected_date" ]; then
        echo "No date selected. Exiting."
        return 1
    fi

    # Show time picker dialog
    time_picker=$(zenity --forms --title="Select Time" \
        --text="Select the time for all commits (24-hour format)" \
        --add-entry="Hour (0-23):" \
        --add-entry="Minute (0-59):" \
        --separator=" " 2>/dev/null)

    # Check if user cancelled
    if [ $? -ne 0 ] || [ -z "$time_picker" ]; then
        echo "No time selected. Exiting."
        return 1
    fi

    # Parse hour and minute
    read -r hour minute <<< "$time_picker"

    # Validate hour and minute
    if ! [[ "$hour" =~ ^([01]?[0-9]|2[0-3])$ ]] || ! [[ "$minute" =~ ^[0-5]?[0-9]$ ]]; then
        zenity --error --text="Invalid time format. Please use 24-hour format (e.g., 14:30)."
        return 1
    fi

    # Format the datetime string
    datetime="${selected_date} ${hour}:${minute}:00"
    
    # Get current branch name
    current_branch=$(git symbolic-ref --short HEAD)
    
    # Create a backup tag before making changes
    backup_tag="backup-before-date-update-$(date +%s)"
    git tag "$backup_tag"
    
    echo "Backup created at tag: $backup_tag"
    
    # Create a temporary file for the filter-branch script
    filter_script=$(mktemp)
    
    # Generate the filter script
    cat > "$filter_script" << EOF
#!/bin/bash
for hash in ${commit_hashes[@]}; do
    if [ "\$GIT_COMMIT" = "\$hash" ]; then
        export GIT_AUTHOR_DATE='$datetime'
        export GIT_COMMITTER_DATE='$datetime'
    fi
done
EOF
    
    # Make the script executable
    chmod +x "$filter_script"
    
    echo "Updating commit dates..."
    
    # Create a backup of the current branch
    backup_branch="backup-${current_branch}-$(date +%s)"
    git branch "$backup_branch"
    echo "Created backup branch: $backup_branch"

    # Process each commit
    updated=0
    for commit_hash in "${commit_hashes[@]}"; do
        echo "Updating commit: $commit_hash to $datetime"
        
        # Checkout the commit
        if ! git checkout -q "$commit_hash"; then
            echo "❌ Failed to checkout commit $commit_hash"
            continue
        fi
        
        # Create a temporary commit with the new date
        if GIT_AUTHOR_DATE="$datetime" GIT_COMMITTER_DATE="$datetime" \
           git commit --amend --no-edit --date="$datetime" --no-verify; then
            
            # Create a temporary branch at this point
            temp_branch="temp-$(git rev-parse --short HEAD)"
            git checkout -b "$temp_branch"
            
            # Rebase the original branch onto this new commit
            if git rebase --onto "$temp_branch" "$commit_hash" "$current_branch"; then
                ((updated++))
                echo "✅ Updated commit $commit_hash"
                # Clean up the temporary branch
                git branch -D "$temp_branch"
            else
                echo "❌ Failed to rebase onto updated commit $commit_hash"
                git rebase --abort 2>/dev/null
                git checkout -q "$current_branch"
                git branch -D "$temp_branch"
                continue
            fi
        else
            echo "❌ Failed to update commit $commit_hash"
            git checkout -q "$current_branch"
            continue
        fi
    done
    
    # Clean up
    rm -f "$filter_script"
    
    # Show summary
    if [ $updated -gt 0 ]; then
        # Update the reflog
        git reflog expire --expire=now --all && git gc --prune=now --aggressive
        
        # Show success message
        zenity --info \
            --title="Commits Updated" \
            --text="Successfully updated $updated commit(s) in local branch '$current_branch'.\n\nOriginal state is saved in branch: $backup_branch"
        
        echo "\n✅ Successfully updated $updated commit(s) in local branch '$current_branch'"
        echo "🔖 Original state is saved in branch: $backup_branch"
        echo "\nTo view the changes:"
        echo "  git log --pretty=format:'%h %ad %s' --date=short"
        echo "\nTo undo these changes:"
        echo "  git checkout $backup_branch"
    else
        # No updates were made, restore from backup
        echo "\n❌ Failed to update any commits. Restoring from backup..."
        git checkout -q "$current_branch"
        git reset --hard "$backup_branch"
        git branch -d "$backup_branch"
        zenity --error \
            --title="Update Failed" \
            --text="Failed to update any commits. No changes were made."
        echo "No changes were made. Original state restored."
        return 1
    fi
}

# Create a temporary file for commit selection
commit_file=$(mktemp)
echo "# Select commits to update by removing the '#' from the beginning of the line" > "$commit_file"
echo "# Save and close this file when done" >> "$commit_file"
echo "" >> "$commit_file"

# Get list of recent commits (last 200) and format for selection
git log -200 --pretty=format:"# %h %ad %s" --date=short >> "$commit_file"

# Let user edit the file
${EDITOR:-nano} "$commit_file"

# Extract selected commit hashes (lines that don't start with #)
commit_hashes=()
while IFS= read -r line; do
    # Skip comment lines and empty lines
    if [[ ! "$line" =~ ^# ]] && [[ -n "$line" ]]; then
        # Extract the commit hash (first field)
        commit_hash=$(echo "$line" | awk '{print $1}')
        commit_hashes+=("$commit_hash")
    fi
done < "$commit_file"

# Clean up
rm -f "$commit_file"

# Check if any commits were selected
if [ ${#commit_hashes[@]} -eq 0 ]; then
    echo "No commits selected. Exiting."
    exit 0
fi

# Show confirmation dialog
zenity --question \
    --title="Confirm Update" \
    --text="You are about to update ${#commit_hashes[@]} commit(s) with the same date and time.\n\nDo you want to continue?" \
    --width=400

if [ $? -eq 0 ]; then
    update_commits_date "${commit_hashes[@]}"
else
    echo "Operation cancelled by user."
    exit 0
fi
