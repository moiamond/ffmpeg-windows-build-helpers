#!/usr/bin/env bash

install_cross_compiler() {
  local win32_gcc="cross_compilers/mingw-w64-i686/bin/i686-w64-mingw32-gcc"
  local win64_gcc="cross_compilers/mingw-w64-x86_64/bin/x86_64-w64-mingw32-gcc"
  
  compiler_flavors=multi

  mkdir -p cross_compilers
  cd cross_compilers

    unset CFLAGS # don't want these "windows target" settings used the compiler itself since it creates executables to run on the local box (we have a parameter allowing them to set them for the script "all builds" basically)
    # pthreads version to avoid having to use cvs for it
    echo "starting to download and build cross compile version of gcc [requires working internet access] with thread count $gcc_cpu_count..."
    echo ""

    # --disable-shared allows c++ to be distributed at all...which seemed necessary for some random dependency which happens to use/require c++...
    local zeranoe_script_name=mingw-w64-build-3.6.7.local
    # add --mingw-w64-ver=git for updated tuner.h [dshow dtv] at least not present in 4.0.6 TODO bump to v 5 when released, if released
    # actually git make "faster" builds for some reason, so leave for now, known working commit: d9ce1abe40efb835609e646b1533acab4a404d03
    local zeranoe_script_options="--clean-build --disable-shared --default-configure  --pthreads-w32-ver=2-9-1 --cpu-count=$gcc_cpu_count --mingw-w64-ver=5.0.1 --gcc-ver=4.9.4"
    cp ../$zeranoe_script_name .

    echo "building win32 cross compiler..."
    nice ./$zeranoe_script_name $zeranoe_script_options --build-type=win32 || exit 1

    echo "building win64 x86_64 cross compiler..."
    nice ./$zeranoe_script_name $zeranoe_script_options --build-type=win64 || exit 1 

    rm -f build.log # left over stuff...
  cd ..
  echo "Done building (or already built) MinGW-w64 cross-compiler(s) successfully..."
  echo `date` # so they can see how long it took :)
}

install_cross_compiler