FROM ghcr.io/linuxserver-labs/prarr:lidarr-plugins-3.1.1.4881

ARG LIDARR_VERSION

RUN \
    apk add --no-cache beets \
    py3-pyacoustid \
    py3-pylast \
    ffmpeg
ENV BEETSDIR="/config/beets" \
    HOME="/config/beets"

VOLUME /config/beets
EXPOSE 8686
