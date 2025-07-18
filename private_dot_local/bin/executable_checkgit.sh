#!/bin/bash

# Store the current directory to return to it later
original_dir=$(pwd)

for f in ./*/; do # Use ./*/ to only iterate over directories
    # Remove trailing slash to get just the directory name
    dir_name=$(basename "$f")

    # Navigate into the subdirectory
    if ! cd "$f"; then
        echo "Could not enter directory: $dir_name"
        continue
    fi

    echo "Checking directory: $dir_name"

    # Check if it's a git repository
    if [ ! -d ".git" ]; then
        echo "  Skipping $dir_name, not a git repository."
        cd "$original_dir" # Go back to the original directory
        continue
    fi

    # Check if a remote named 'origin' exists
    if git remote get-url origin &> /dev/null; then
        echo "  '$dir_name' has a remote named 'origin'."
    else
        echo "  '$dir_name' DOES NOT have a remote named 'origin'."
    fi

    # Return to the original directory before the next iteration
    cd "$original_dir"
done

echo "Script finished."
