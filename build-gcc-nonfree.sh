#!/bin/sh -eux

# Compiler: gcc or clang
# Resulting license: nonfree and unredistributable

build_dir=build-gcc-nonfree
install_dir=/usr/local
nproc=$(nproc)

rm -rf ${build_dir}
mkdir ${build_dir}
cd ${build_dir}

../configure              \
  --prefix=${install_dir} \
  --enable-gpl            \
  --enable-nonfree        \
  --disable-doc           \
  --disable-htmlpages     \
  --disable-manpages      \
  --disable-podpages      \
  --disable-txtpages      \
  --enable-libmp3lame     \
  --enable-libx264        \
  --build-suffix=_usp     \
  --disable-stripping

make -j${nproc} V=1

sudo make V=1 install-progs
