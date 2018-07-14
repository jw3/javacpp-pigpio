#!/bin/bash
# This file is meant to be included by the parent cppbuild.sh script
if [[ -z "$PLATFORM" ]]; then
    pushd ..
    bash cppbuild.sh "$@" pigpio
    popd
    exit
fi

PIGPIO_VERSION_NAME="V67"
PIGPIO_VERSION_SHA="934874be2fa34a525beb33e8cb75e378df587860"
echo "downloading pigpio $PIGPIO_VERSION_NAME"
download https://github.com/joan2937/pigpio/archive/${PIGPIO_VERSION_SHA}.zip pigpio-${PIGPIO_VERSION_SHA}.zip

mkdir -p ${PLATFORM}
cd ${PLATFORM}
INSTALL_PATH=`pwd`
mkdir -p include lib
unzip -o ../pigpio-${PIGPIO_VERSION_SHA}.zip
cd pigpio-${PIGPIO_VERSION_SHA}

case ${PLATFORM} in
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
