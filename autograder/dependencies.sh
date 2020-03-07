#!/bin/sh

# Bazel (for stargrade)
apt-get install curl -y
curl https://bazel.build/bazel-release.pub.gpg | apt-key add -
echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
apt-get update && apt-get install bazel -y

# Make
apt-get install build-essential -y

# GTest
apt-get  install libgtest-dev -y
apt-get install cmake -y
cd /usr/src/gtest
cmake CMakeLists.txt
make
cp *.a /usr/lib/

# Stargrade
git clone git@github.com:adsnaider/StarGrade.git
cd StarGrade
bazel build -c opt :stargrade-deb
apt-get install ./bazel-bin/stargrade-deb.deb
cd ../
rm -rf StarGrade

# nlohmann json
wget https://github.com/nlohmann/json/releases/download/v3.7.3/include.zip
unzip -d nlohmann include.zip
rm include.zip
cd nlohmann/include
cp -r nlohmann /usr/local/include/
cd ../../
rm -r nlohmann
