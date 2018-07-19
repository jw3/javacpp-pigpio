#!/bin/bash
# This file is meant to be included by the parent cppbuild.sh script
if [[ -z "$PLATFORM" ]]; then
    pushd ..
    bash cppbuild.sh "$@" pigpio
    popd
    exit
fi

readonly INSTALL_PATH=$(pwd)
mkdir -p "$PLATFORM/include" "$PLATFORM/lib"

PIGPIO_VERSION="V$PIGPIO_MAJOR_VERSION"
echo "downloading pigpio $PIGPIO_VERSION"

if [[ -z "$PIGPIO_REPO" ]]; then
  download "https://github.com/joan2937/pigpio/archive/$PIGPIO_VERSION.zip" "pigpio-$PIGPIO_VERSION.zip"
  cd "$PLATFORM"
  unzip -o "../pigpio-$PIGPIO_VERSION.zip"
else
  cd "$PLATFORM"
  git clone "$PIGPIO_REPO" "pigpio-$PIGPIO_VERSION"
fi

cd "pigpio-$PIGPIO_VERSION"

case ${PLATFORM} in
    linux-x86*)
        armcc="${GCC_ARM_PREFIX:-}"
        if [[ ! -z "$armcc" ]]; then armcc="$armcc"; fi
        make -j4 CFLAGS=-DEMBEDDED_IN_VM CROSS_PREFIX="$armcc"
        cp pigpio*.h ../include
        cp libpigpio*.so ../lib
        ;;
    linux-arm)
        make -j4 CFLAGS=-DEMBEDDED_IN_VM
        cp pigpio*.h ../include
        cp libpigpio*.so ../lib
        ;;
    *)
        echo "Error: Platform \"$PLATFORM\" is not supported"
        ;;
esac

cd ../..
