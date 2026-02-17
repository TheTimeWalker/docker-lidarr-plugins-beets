FROM ghcr.io/linuxserver-labs/prarr:lidarr-plugins-3.1.1.4884

ARG LIDARR_VERSION

# Copy pre-compiled binaries from the build context
COPY mp3gain mp3val /usr/bin/

# Make the binaries executable
RUN chmod +x /usr/bin/mp3gain /usr/bin/mp3val

# Install build and runtime packages, and cleanup
RUN echo "**** install packages ****" && \
    apk add --no-cache --virtual=build-dependencies \
      build-base \
      cairo-dev \
      cargo \
      cmake \
      ffmpeg-dev \
      fftw-dev \
      git \
      gobject-introspection-dev \
      jpeg-dev \
      libpng-dev \
      mpg123-dev \
      openjpeg-dev \
      py3-pip \
      python3-dev \
      pkgconfig && \
    apk add --no-cache \
      chromaprint \
      expat \
      expect \
      ffmpeg \
      fftw \
      flac \
      gdbm \
      gobject-introspection \
      gst-plugins-good \
      gstreamer \
      imagemagick \
      jpeg \
      lame \
      libffi \
      libpng \
      mpg123 \
      nano \
      openjpeg \
      python3 \
      sqlite-libs && \
    echo "**** setup virtualenv for pip packages ****" && \
    python3 -m venv /opt/venv && \
    source /opt/venv/bin/activate && \
    pip install -U --no-cache-dir --verbose pip wheel && \
    pip config set global.index-url http://192.168.1.104:3141/root/pypi/+simple/ && \
    pip config set global.trusted-host 192.168.1.104 && \
    pip install -U --no-cache-dir --verbose \
      beautifulsoup4 \
      beets \
      beets-extrafiles \
      beetcamp \
      discogs-client \
      flask \
      PyGObject \
      pillow==9.5.0 \
      pyacoustid \
      pylast \
      requests \
      requests_oauthlib \
      unidecode && \
    deactivate && \
    apk del --purge build-dependencies && \
    rm -rf /tmp/* $HOME/.cache $HOME/.cargo

# Environment settings
ENV BEETSDIR="/config/beets" \
    EDITOR="nano" \
    HOME="/config/beets" \
    PATH="/opt/venv/bin:$PATH"
