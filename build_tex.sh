#!/bin/sh

# Check if a path is provided as an argument, otherwise default to /workspace/
PATH_TO_WORKSPACE=${1:-/workspace}

# Copy files from the specified path to the current directory
cp -r "$PATH_TO_WORKSPACE"/* .

# Function to compile a LaTeX file with xelatex and biber
compile_tex_file() {
    local file=$1
    local base_name=$(basename "$file" .tex)

    # Compile with xelatex
    texliveonfly --compiler=xelatex --arguments='-shell-escape' "$file"

    # Run biber if needed
    if [ -e "$base_name.bcf" ]; then
        biber "$base_name"
    fi

    # Second and third run of xelatex
    xelatex -shell-escape "$file"
    xelatex -shell-escape "$file"
}

# Find all .tex files and compile each in parallel
for file in *.tex; do
    compile_tex_file "$file" &
done

# Wait for all background processes to finish
wait

# Create a build directory within the specified path and copy all PDFs to it
BUILD_DIR="$PATH_TO_WORKSPACE"/build
mkdir -p "$BUILD_DIR"
cp *.pdf "$BUILD_DIR"