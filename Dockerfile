
FROM ubuntu:xenial
MAINTAINER moiamond <moiamond@gmail.com>

RUN apt-get update && apt-get install -y \
        subversion \
        curl \
        texinfo \
        g++ \
        bison \
        flex \
        cvs \
        yasm \
        automake \
        libtool \
        autoconf \
        gcc \
        cmake \
        git \
        make \
        pkg-config \
        zlib1g-dev \
        mercurial \
        unzip \
        pax \
        wget \
        xz-utils \
        ed \
        nasm \
        && rm -rf /var/lib/apt/list/*

WORKDIR /build/sandbox

COPY ./patches/mingw-w64-build-3.6.7.local mingw-w64-build-3.6.7.local
COPY ./install_cross_compile.sh install_cross_compile.sh

RUN ./install_cross_compile.sh
