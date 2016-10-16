#!/bin/bash
# This file is meant to be included by the parent cppbuild.sh script
if [[ -z "$PLATFORM" ]]; then
    pushd ..
    bash cppbuild.sh "$@" pigpio
    popd
    exit
fi

PIGPIO_VERSION=master
download https://github.com/joan2937/pigpio/archive/master.zip pigpio-$PIGPIO_VERSION.zip

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
    linux-armhf)
        make -j4
        cp pigpio*.h ../include
        cp libpigpio*.so ../lib
        ;;
    *)
        echo "Error: Platform \"$PLATFORM\" is not supported"
        ;;
esac

cd ../..
