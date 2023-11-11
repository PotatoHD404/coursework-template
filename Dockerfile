# Start from the LaTeX base image
FROM aergus/latex:latest

# Install necessary tools and git-latexdiff
RUN apt-get update && \
    apt-get install -y git make && \
    git clone https://gitlab.com/git-latexdiff/git-latexdiff.git && \
    cd git-latexdiff && \
    make install-bin && \
    cd .. && \
    rm -rf git-latexdiff && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set a default command if needed (e.g., launching a shell)
CMD ["/bin/bash"]
