#!/bin/bash

readonly javacpp_dir=/tmp/javacpp
readonly presets_dir=/tmp/javacpp-presets

git clone https://github.com/bytedeco/javacpp ${javacpp_dir}
git clone https://github.com/bytedeco/javacpp-presets ${presets_dir}

cp -r "$(pwd)/pigpio" "$presets_dir/pigpio"
sed -i "s#</modules>#<module>pigpio</module></modules>#g" /tmp/javacpp-presets/pom.xml

cd ${javacpp_dir}
mvn install

cd ${presets_dir}
mvn install --projects .,pigpio
