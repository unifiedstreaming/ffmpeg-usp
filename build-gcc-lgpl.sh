#!/bin/sh -eux

# "THE BEER-WARE LICENSE" (Revision CS-42):
#
# This file was written by the CodeShop developers.  As long as you
# retain this notice you can do whatever you want with it.
# If we meet some day, and you think this file is worth it, you can
# buy us a beer in return.  Even if you do that, this file still
# comes WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

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
