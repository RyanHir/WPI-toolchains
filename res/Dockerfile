# Requires docker 17.05 or newer.
# For installation, see https://docs.docker.com/install/linux/docker-ce/ubuntu/
ARG BASE
FROM docker.io/ubuntu:${BASE}

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update && apt-get install -y \
    bison \
    build-essential \
    cmake \
    file \
    flex \
    gawk \
    mingw-w64 \
    m4 \
    ninja-build \
    python3 \
    python3-packaging \
    python3-requests \
    python3-yaml \
    rsync \
    sudo \
    texinfo \
    wget \
    zip \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build
