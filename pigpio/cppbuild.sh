#!/bin/bash
# This file is meant to be included by the parent cppbuild.sh script
if [[ -z "$PLATFORM" ]]; then
    pushd ..
    bash cppbuild.sh "$@" pigpio
    popd
    exit
fi

PIGPIO_VERSION=1aa4cca8a69d4f8f8ce198178dbd7f436b4f503c
download https://github.com/joan2937/pigpio/archive/$PIGPIO_VERSION.zip pigpio-$PIGPIO_VERSION.zip

mkdir -p $PLATFORM
cd $PLATFORM
INSTALL_PATH=`pwd`
mkdir -p include lib
unzip -o ../pigpio-$PIGPIO_VERSION.zip
cd pigpio-$PIGPIO_VERSION

case $PLATFORM in
    linux-x86)
        make -j4
        cp pigpio*.h ../include
        cp libpigpio*.so ../lib
        ;;
    linux-x86_64)
        make -j4
        cp pigpio*.h ../include
        cp libpigpio*.so ../lib
        ;;
    linux-arm)
        make -j4
        cp pigpio*.h ../include
        cp libpigpio*.so ../lib
        ;;
    *)
        echo "Error: Platform \"$PLATFORM\" is not supported"
        ;;
esac

cd ../..
