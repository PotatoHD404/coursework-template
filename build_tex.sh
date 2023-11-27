#!/bin/sh

# Check if a path is provided as an argument, otherwise default to /workspace/
PATH_TO_WORKSPACE=${1:-/workspace}

# Copy files from the specified path to the current directory
cp -r "$PATH_TO_WORKSPACE"/* .

# Find all .tex files and start compiling each in the background
for file in *.tex; do
    texliveonfly --compiler=xelatex --arguments='-shell-escape' "$file" &
done

# Wait for all background processes to finish
wait

# Create a build directory within the specified path and copy all PDFs to it
BUILD_DIR="$PATH_TO_WORKSPACE"/build
mkdir -p "$BUILD_DIR"
cp *.pdf "$BUILD_DIR"
