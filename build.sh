#!/usr/bin/env bash

readonly javacpp_dir=/tmp/javacpp
readonly presets_dir=/tmp/javacpp-presets
#export JAVA_HOME=/usr/local/java

if [[ "$1" == "clean" ]]; then
  rm -rf ${javacpp_dir}
  rm -rf ${presets_dir}

  git clone https://github.com/bytedeco/javacpp ${javacpp_dir}
  git clone https://github.com/bytedeco/javacpp-presets ${presets_dir}

  cp -r "$(pwd)/pigpio" "$presets_dir/pigpio"
  sed -i "s#</modules>#<module>pigpio</module></modules>#g" /tmp/javacpp-presets/pom.xml
fi

cd ${javacpp_dir}
mvn install

cd ${presets_dir}
mvn install --projects .,pigpio
