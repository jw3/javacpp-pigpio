#!/usr/bin/env bash

export version="${VERSION_STRING:-0}"

readonly sourcedir="${SOURCE_DIR:-${PWD}}"

readonly javacpp_dir="${JAVACPP_DIR:-/tmp/javacpp}"
readonly presets_dir="${JAVACPP_PRESETS_DIR:-/tmp/javacpp-presets}"

readonly javacpp_repo="${JAVACPP_REPO:-https://github.com/bytedeco/javacpp}"
readonly presets_repo="${JAVACPP_PRESETS_REPO:-https://github.com/bytedeco/javacpp-presets}"

readonly javacpp_ver="${JAVACPP_VER:-1.4.1}"

export PIGPIO_REPO="${PIGPIO_REPO:-https://github.com/joan2937/pigpio}"
export PIGPIO_MAJOR_VERSION=67

readonly library_ver="$PIGPIO_MAJOR_VERSION.$version-$javacpp_ver"

_echoerr() { if [[ ${QUIET} -ne 1 ]]; then echo "[debug]: $@" 1>&2; fi }
_checkerr() { ec=${1}; if [[ ${ec} -ne 0 ]]; then _echoerr "$2 failed with error code $ec"; exit ${ec}; fi }

if [[ -z "$JAVA_HOME" ]]; then _echoerr "java home is not defined"; fi

if [[ "$1" == "clean" ]]; then
  rm -rf ${javacpp_dir}
  rm -rf ${presets_dir}

  git clone ${javacpp_repo} ${javacpp_dir}
  git clone ${presets_repo} ${presets_dir}
fi

cd ${javacpp_dir}
git checkout "$javacpp_ver"
_checkerr $? "javacpp checkout $javacpp_ver"

mvn install

cd ${presets_dir}
git checkout "$javacpp_ver"
_checkerr $? "presets checkout $javacpp_ver"

cp -r "$sourcedir/pigpio" "$presets_dir/pigpio"
sed -i "s#</modules>#<module>pigpio</module></modules>#g" "$presets_dir/pom.xml"
sed -i "s#__JAVACPP_VER__#${javacpp_ver}#g" "$presets_dir/pigpio/pom.xml"
sed -i "s#__LIBRARY_VER__#${library_ver}#g" "$presets_dir/pigpio/pom.xml"

mvn install --projects .,pigpio -Dpigpio.major="$PIGPIO_MAJOR_VERSION" -Dlibrary.version="$version"
