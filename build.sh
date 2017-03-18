#!/bin/bash

readonly javacpp_dir=/tmp/javacpp
readonly presets_dir=/tmp/javacpp-presets
export JAVA_HOME=/usr/local/java

git clone https://github.com/bytedeco/javacpp ${javacpp_dir}
git clone https://github.com/bytedeco/javacpp-presets ${presets_dir}

cp ${PWD}/javacpp/properties/* ${javacpp_dir}/src/main/resources/org/bytedeco/javacpp/properties
cp -r ${PWD}/pigpio ${presets_dir}/pigpio
sed -i "s#</modules>#<module>pigpio</module></modules>#g" ${presets_dir}/pom.xml

cd ${javacpp_dir}
mvn install

cd ${presets_dir}
mvn install --projects .,pigpio
