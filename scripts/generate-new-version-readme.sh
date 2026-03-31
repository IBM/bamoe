#!/bin/bash

# Usage: ./generate-new-version-readme.sh <base-version> <new-version>
# This script processes README-latest.md files in readmes directories,
# creating versioned copies when the header contains the base version.

set -e

# Validate arguments
[[ $# -ne 2 ]] && { echo "Usage: $0 <base-version> <new-version>" >&2; exit 1; }
[[ -z "$1" || -z "$2" ]] && { echo "Error: versions cannot be empty" >&2; exit 1; }

BASE_VERSION="$1"
NEW_VERSION="$2"

echo "Processing README files: $BASE_VERSION -> $NEW_VERSION"
echo "================================================"

# Find all readmes directories
READMES_DIRS=$(find . -type d -name "readmes" 2>/dev/null)
[[ -z "$READMES_DIRS" ]] && { echo "Error: no 'readmes' directories found" >&2; exit 1; }

# Process each readmes directory
while IFS= read -r readmes_dir; do
    # Skip directories with DEPRECATED in the path
    if [[ "$readmes_dir" == *"DEPRECATED"* ]]; then
        echo "Skipped: $readmes_dir (DEPRECATED)"
        continue
    fi
    
    latest_file="$readmes_dir/README-latest.md"
    
    # Check if README-latest.md exists
    if [[ ! -f "$latest_file" ]]; then
        echo "Skipped: $readmes_dir (no README-latest.md found)"
        continue
    fi
    
    # Read the first line (header) of the file
    header=$(head -n 1 "$latest_file")
    
    # Check if header contains the new version (already updated)
    if [[ "$header" == *"$NEW_VERSION"* ]]; then
        echo "Skipped: $latest_file (already contains $NEW_VERSION)"
        continue
    fi
    
    # Check if header contains the base version
    if [[ "$header" == *"$BASE_VERSION"* ]]; then
        base_versioned_file="$readmes_dir/README-$BASE_VERSION.md"
        
        # Rename README-latest.md to README-<base-version>.md
        if [[ -f "$base_versioned_file" ]]; then
            echo "Warning: $base_versioned_file already exists, skipping rename"
            echo "Skipped: $latest_file (versioned file already exists)"
            continue
        fi
        
        mv "$latest_file" "$base_versioned_file"
        echo "Renamed: $latest_file -> $base_versioned_file"
        
        # Create a copy of the versioned file as README-latest.md
        cp "$base_versioned_file" "$latest_file"
        echo "Created: $latest_file (copy of $base_versioned_file)"
        
        # Update the contents of README-latest.md replacing base-version with new-version
        sed -i "s/$BASE_VERSION/$NEW_VERSION/g" "$latest_file"
        echo "Updated: $latest_file ($BASE_VERSION -> $NEW_VERSION)"
        echo ""
    else
        echo "Skipped: $latest_file (header does not contain $BASE_VERSION)"
    fi
    
done <<< "$READMES_DIRS"

echo "================================================"
echo "Done."

# Made with Bob
