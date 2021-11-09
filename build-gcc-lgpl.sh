#!/bin/sh -eux

# Compiler: gcc or clang
# Resulting license: LGPL v2.1

build_dir=build-gcc-lgpl
install_dir=/usr/local
nproc=$(nproc)

rm -rf ${build_dir}
mkdir ${build_dir}
cd ${build_dir}

../configure              \
  --prefix=${install_dir} \
  --disable-static        \
  --enable-shared         \
  --disable-autodetect    \
  --disable-programs      \
  --disable-doc           \
  --disable-htmlpages     \
  --disable-manpages      \
  --disable-podpages      \
  --disable-txtpages      \
  --disable-hwaccels      \
  --build-suffix=_usp     \
  --disable-stripping

make -j${nproc} V=1

sudo make V=1 install
