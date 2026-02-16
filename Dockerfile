FROM nvidia/cuda:12.4.0-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

ARG SEANIME_VERSION

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    ca-certificates \
    tar \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN wget -O ffmpeg-dl.tar.xz \
    https://repo.jellyfin.org/files/ffmpeg/linux/latest-7.x/amd64/jellyfin-ffmpeg_7.1.3-3_portable_linux64-gpl.tar.xz \
    && tar -xvf ffmpeg-dl.tar.xz \
    && mv ffmpeg /usr/local/bin/ffmpeg \
    && mv ffprobe /usr/local/bin/ffprobe \
    && rm ffmpeg-dl.tar.xz

RUN wget -O seanime.tar.gz \
    https://github.com/5rahim/seanime/releases/download/${SEANIME_VERSION}/seanime-${SEANIME_VERSION#v}_Linux_x86_64.tar.gz \
    && tar -xzf seanime.tar.gz \
    && chmod +x seanime \
    && rm seanime.tar.gz

RUN mkdir -p /.config

EXPOSE 43211

CMD ["/app/seanime"]
