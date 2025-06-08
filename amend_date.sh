#!/bin/bash

# Check if date parameter is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 YYYY-MM-DD [HH:MM:SS]"
    echo "Example: $0 2025-06-06 14:34:00"
    exit 1
fi

date_str="$1"
time_str="${2:-00:00:00}"

# Combine date and time
datetime="$date_str $time_str"

# Check if the date is valid
if ! date "+%Y-%m-%d %H:%M:%S" -d "$datetime" >/dev/null 2>&1; then
    echo "Error: Invalid date/time format. Use YYYY-MM-DD [HH:MM:SS]"
    exit 1
fi

# Check if we're in a git repository
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not a git repository"
    exit 1
fi

# Check if there are any commits
if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
    echo "Error: No commits found in this repository."
    exit 1
fi

# Get the current commit message
commit_msg=$(git log -1 --pretty=%B)

# Create a temporary file for the commit message
tmp_msg=$(mktemp)
echo "$commit_msg" > "$tmp_msg"

# Amend the commit with the new date
GIT_AUTHOR_DATE="$datetime" GIT_COMMITTER_DATE="$datetime" \
    git commit --amend --date="$datetime" -F "$tmp_msg"

# Clean up
rm -f "$tmp_msg"

echo "Commit date updated to: $datetime"
