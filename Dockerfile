FROM moiamond/ffmpeg-windows-build-helpers:crosstool-windows
MAINTAINER moiamond <moiamond@gmail.com>

WORKDIR /build

COPY ./cross_compile_ffmpeg.sh cross_compile_ffmpeg.sh
