# Start from the LaTeX base image
FROM aergus/latex:latest

# Install git-latexdiff
RUN apt-get update && \
    git clone https://gitlab.com/git-latexdiff/git-latexdiff.git && \
    cd git-latexdiff && \
    make install-bin && \
    cd .. && \
    rm -rf git-latexdiff

# Create a directory for custom fonts and install required packages
RUN mkdir /usr/share/fonts/custom
RUN apt-get install -y git make fontconfig

# Copy font files from a local directory to the container
# Ensure you have the font files in the 'fonts' directory on your host system
COPY fonts/*.ttf /usr/share/fonts/custom/

# Update the font cache to include the custom fonts
RUN fc-cache -f -v

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set a default command if needed (e.g., launching a shell)
CMD ["/bin/bash"]
