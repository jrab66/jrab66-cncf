"""Script to prepare the module for semantic-release."""

import os
import sys
import json

skeleton_contents = {
    "private": True,
    "devDependencies": {
        "@semantic-release/github": "^9.0.3",
        "semantic-release": "^21.0.5"
    },
    "release": {
        "branches": [
            "main"
        ]
    },
    "plugins": [
        "@semantic-release/commit-analyzer",
        "@semantic-release/release-notes-generator",
        "@semantic-release/github"
    ]
}


def open_file(filename):
    """
    Open a file and return its contents.

    Args:
        filename: The file to open.

    Returns:
        dict: The contents of the file.
    """
    try:
        with open(filename, "r") as file:
            return json.loads(file.read())
    except FileNotFoundError:
        raise FileNotFoundError(f"File {filename} not found.")

    # Update the package_json file with skeleton contents


def update_package_json(package_json, package_json_skeleton):
    """
    Update the package_json file with skeleton contents.

    Args:
        package_json: The package_json file to update.
        package_json_skeleton: The skeleton contents to update with.

    Returns:
        dict: The updated package_json file.
    """
    try:
        package_json_skeleton["name"] = package_json["name"]
        package_json_skeleton["description"] = package_json["description"]
    except KeyError as error_message:
        print("Failed!", str(error_message))
        sys.exit(1)

    return package_json_skeleton


def write_file(filename, contents):
    """
    Write the contents to the file.

    Args:
        filename: The file to write to.
        contents: The contents to write to the file.
    """
    try:
        with open(filename, "w") as file:
            file.write(json.dumps(contents, indent=4))
    except FileNotFoundError:
        raise FileNotFoundError(f"File {filename} not found.")


def main():
    """Main function."""
    try:
        # Load the original package_json file
        package_json = open_file("package.json")
    except FileNotFoundError as error_message:
        print("Failed!", str(error_message))
        sys.exit(1)

    # Update the package_json file with skeleton contents
    try:
        updated_package_json = update_package_json(package_json, skeleton_contents)
    except KeyError as error_message:
        print("Failed!", str(error_message))
        sys.exit(1)

    # Write the updated package_json file
    try:
        write_file("package.json", updated_package_json)
    except FileNotFoundError as error_message:
        print("Failed!", str(error_message))
        sys.exit(1)

    print("Processed successfully!")


if __name__ == "__main__":
    main()
