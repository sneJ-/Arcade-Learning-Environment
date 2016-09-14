#!/bin/sh

apt-get install libsdl1.2-dev libsdl-gfx1.2-dev libsdl-image1.2-dev cmake -y
mkdir build && cd build
cmake -DUSE_SDL=ON -DUSE_RLGLUE=OFF -DBUILD_EXAMPLES=ON ..
make -j 4
cd ..
pip install .

