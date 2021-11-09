#!/bin/sh -eux

# Compiler: MSVC 14 (aka Visual Studio 2019)
# Resulting license: nonfree and unredistributable

build_dir=bld64-msvc-14-nonfree
install_dir=../out64-msvc-14-nonfree
nproc=${NUMBER_OF_PROCESSORS}

rm -rf ${build_dir}
mkdir ${build_dir}
cd ${build_dir}

../configure              \
                          \
  --prefix=${install_dir} \
                          \
  --enable-gpl            \
  --enable-nonfree        \
                          \
  --disable-doc           \
  --disable-htmlpages     \
  --disable-manpages      \
  --disable-podpages      \
  --disable-txtpages      \
                          \
  --enable-libmp3lame     \
  --enable-libx264        \
                          \
  --toolchain=msvc        \
  --build-suffix=_usp     \
                          \
  --disable-stripping

make -j${nproc} V=1

make V=1 install-progs
