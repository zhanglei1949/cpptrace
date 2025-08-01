#!/bin/bash

mkdir zstd
cd zstd
git init
git remote add origin https://github.com/facebook/zstd.git
git fetch --depth 1 origin 794ea1b0afca0f020f4e57b6732332231fb23c70 # 1.5.6
git checkout FETCH_HEAD
make -j
sudo make install

cd ..

mkdir libdwarf
cd libdwarf
git init
git remote add origin https://github.com/jeremy-rifkin/libdwarf-lite.git
git fetch --depth 1 origin 5dfb2cd2aacf2bf473e5bfea79e41289f88b3a5f # 2.1.0
git checkout FETCH_HEAD
mkdir build
cd build
cmake .. -GNinja -DPIC_ALWAYS=TRUE -DBUILD_DWARFDUMP=FALSE
sudo ninja install

cd ../..

mkdir googletest
cd googletest
git init
git remote add origin https://github.com/google/googletest.git
git fetch --depth 1 origin f8d7d77c06936315286eb55f8de22cd23c188571
git checkout FETCH_HEAD
mkdir build
cd build
cmake .. -GNinja -DCMAKE_INSTALL_PREFIX=/tmp/gtest_install
sudo ninja install
rm -rf *
cmake .. -GNinja -DCMAKE_CXX_COMPILER=clang++-18 -DCMAKE_CXX_FLAGS=-stdlib=libc++ -DCMAKE_INSTALL_PREFIX=/tmp/gtest_install_libcxx
sudo ninja install
