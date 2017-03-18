#!/bin/bash
# This file is meant to be included by the parent cppbuild.sh script
if [[ -z "$PLATFORM" ]]; then
    pushd ..
    bash cppbuild.sh "$@" pigpio
    popd
    exit
fi

PIGPIO_VERSION=master
download https://github.com/joan2937/pigpio/archive/$PIGPIO_VERSION.zip pigpio-$PIGPIO_VERSION.zip

mkdir -p $PLATFORM
cd $PLATFORM
INSTALL_PATH=`pwd`
mkdir -p include lib
unzip -o ../pigpio-$PIGPIO_VERSION.zip
cd pigpio-$PIGPIO_VERSION

case $PLATFORM in
    linux-arm)
        make -j4 CFLAGS='-marm -march=armv8-a -mtune=cortex-a53 -mfpu=neon-fp-armv8 -mhard-float -mfloat-abi=hard -O3 -s'
        cp pigpio*.h ../include
        cp libpigpio*.so ../lib
        ;;
    *)
        echo "Error: Platform \"$PLATFORM\" is not supported"
        ;;
esac

cd ../..
