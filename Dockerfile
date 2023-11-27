# Use Alpine Linux as the base image
FROM alpine:latest

# Define user parameters as arguments
ARG USER_NAME=latex
ARG USER_HOME=/home/latex
ARG USER_ID=1000
ARG USER_GECOS=LaTeX

# Install TeX Live and other necessary tools using apk
# Note: Alpine uses different package names and might not have all Debian packages
RUN apk add --no-cache \
    # Install base TeX Live and any specific packages you need
    perl \
    tar \
    # You might need to find alternatives or build some packages from source
    # for those not available in Alpine
    wget \
    git \
    openssh-client \
    make \
    pandoc \
    py-pygments \
    python3 \
    openjdk11-jre-headless \
    shadow \
    fontconfig \
    msttcorefonts-installer && \
    update-ms-fonts && \
    git clone https://gitlab.com/git-latexdiff/git-latexdiff.git && \
    cd git-latexdiff && \
    make install-bin && \
    cd .. && \
    rm -rf git-latexdiff && \
    rm -rf /var/cache/apk/*

WORKDIR /tmp/install-tl-unx

ENV PATH /usr/local/bin/texlive:$PATH

RUN echo "selected_scheme scheme-basic" >> texlive.profile && \
    echo "collection-basic 1" >> texlive.profile && \
    echo "collection-latex 1" >> texlive.profile && \
    echo "collection-xetex 1" >> texlive.profile && \
    echo "tlpdbopt_install_docfiles 0" >> texlive.profile && \
    echo "tlpdbopt_install_srcfiles 0" >> texlive.profile

# Download and install tlmgr
RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
    tar --strip-components=1 -xvf install-tl-unx.tar.gz && \
    ./install-tl --profile=texlive.profile && \
    rm -rf /tmp/install-tl-unx && \
    ln -sf /usr/local/texlive/*/bin/* /usr/local/bin/texlive && \
    wget -O /usr/local/bin/texliveonfly http://mirrors.ctan.org/support/texliveonfly/texliveonfly.py && \
    chmod +x /usr/local/bin/texliveonfly && \
    rm -rf /tmp/install-tl-unx

RUN tlmgr update --self && \
    tlmgr install catchfile eso-pic pdfpages greek-fontenc titling caption biblatex logreq biblatex-gost \
    euenc filehook fontspec makecmds polyglossia tipa xkeyval xunicode \
    csquotes metalogo xltxtra multirow fp ms pgf xcolor paralist titlesec appendix listings \
    pdflscape setspace enumitem float framed fvextra lineno minted newfloat xstring fancyvrb \
    upquote booktabs
# Create a directory for custom fonts
RUN mkdir -p /usr/share/fonts/custom

# Copy font files from a local directory to the container
# Ensure you have the font files in the 'fonts' directory on your host system
COPY fonts/*.ttf fonts/*.otf /usr/share/fonts/custom/

# Update the font cache to include the custom fonts
RUN fc-cache -f -v

# Set default working directory
WORKDIR $USER_HOME

COPY ./dependencies/* .

COPY ./build_tex.sh .

# Set a default command if needed (e.g., launching a shell)
CMD ["/bin/ash"]
