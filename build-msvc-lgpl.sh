#!/bin/sh -eux

# Compiler: MSVC 14 (aka Visual Studio 2019)
# Resulting license: LGPL v2.1

# Debug build
build_dir=bld64-msvc-14-lgpl/debug
install_dir=../../out64-msvc-14-lgpl/debug
nproc=${NUMBER_OF_PROCESSORS}

rm -rf ${build_dir}
mkdir -p ${build_dir}
cd ${build_dir}

../../configure                 \
  --prefix=${install_dir}       \
  --disable-static              \
  --enable-shared               \
  --disable-autodetect          \
  --disable-programs            \
  --disable-doc                 \
  --disable-htmlpages           \
  --disable-manpages            \
  --disable-podpages            \
  --disable-txtpages            \
  --disable-hwaccels            \
  --toolchain=msvc              \
  --extra-cflags="-MDd -Z7"     \
  --extra-ldflags="-debug:full" \
  --build-suffix=_usp           \
  --disable-debug               \
  --disable-stripping

make -j${nproc} V=1

make V=1 install

cd ../../

# Release build
build_dir=bld64-msvc-14-lgpl/release
install_dir=../../out64-msvc-14-lgpl/release
nproc=${NUMBER_OF_PROCESSORS}

rm -rf ${build_dir}
mkdir -p ${build_dir}
cd ${build_dir}

../../configure                 \
  --prefix=${install_dir}       \
  --disable-static              \
  --enable-shared               \
  --disable-autodetect    \
  --disable-programs            \
  --disable-doc                 \
  --disable-htmlpages           \
  --disable-manpages            \
  --disable-podpages            \
  --disable-txtpages            \
  --disable-hwaccels      \
  --toolchain=msvc              \
  --extra-cflags="-MD -Z7"      \
  --extra-ldflags="-debug:full" \
  --build-suffix=_usp           \
  --disable-debug               \
  --disable-stripping

make -j${nproc} V=1

make V=1 install

cd ../../

# Sanity check include dirs: debug and release should be exactly identical.
diff -qr out64-msvc-14-lgpl/debug/include out64-msvc-14-lgpl/release/include

# We need only one copy of the headers.
rm -rf out64-msvc-14-lgpl/include out64-msvc-14-lgpl/debug/include
mv out64-msvc-14-lgpl/release/include out64-msvc-14-lgpl

# Move DLLs, import libs and def files from out64 subdirs.
mv \
  out64-msvc-14-lgpl/debug/bin/*.dll \
  out64-msvc-14-lgpl/debug/bin/*.lib \
  out64-msvc-14-lgpl/debug/lib/*.def \
  out64-msvc-14-lgpl/debug

mv \
  out64-msvc-14-lgpl/release/bin/*.dll \
  out64-msvc-14-lgpl/release/bin/*.lib \
  out64-msvc-14-lgpl/release/lib/*.def \
  out64-msvc-14-lgpl/release

# Cleanup out64 subdir leftovers that we don't want.
rm -rf \
  out64-msvc-14-lgpl/debug/bin \
  out64-msvc-14-lgpl/debug/lib \
  out64-msvc-14-lgpl/debug/share \
  out64-msvc-14-lgpl/release/bin \
  out64-msvc-14-lgpl/release/lib \
  out64-msvc-14-lgpl/release/share

# Copy pdb files from bld64 subdirs.
cp \
  bld64-msvc-14-lgpl/debug/libavcodec/*.pdb \
  bld64-msvc-14-lgpl/debug/libavdevice/*.pdb \
  bld64-msvc-14-lgpl/debug/libavfilter/*.pdb \
  bld64-msvc-14-lgpl/debug/libavformat/*.pdb \
  bld64-msvc-14-lgpl/debug/libavutil/*.pdb \
  bld64-msvc-14-lgpl/debug/libswresample/*.pdb \
  bld64-msvc-14-lgpl/debug/libswscale/*.pdb \
  out64-msvc-14-lgpl/debug

cp \
  bld64-msvc-14-lgpl/release/libavcodec/*.pdb \
  bld64-msvc-14-lgpl/release/libavdevice/*.pdb \
  bld64-msvc-14-lgpl/release/libavfilter/*.pdb \
  bld64-msvc-14-lgpl/release/libavformat/*.pdb \
  bld64-msvc-14-lgpl/release/libavutil/*.pdb \
  bld64-msvc-14-lgpl/release/libswresample/*.pdb \
  bld64-msvc-14-lgpl/release/libswscale/*.pdb \
  out64-msvc-14-lgpl/release

# Show end result.
ls -l \
  out64-msvc-14-lgpl/include \
  out64-msvc-14-lgpl/debug \
  out64-msvc-14-lgpl/release
