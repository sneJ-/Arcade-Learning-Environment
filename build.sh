#!/bin/sh

#install main ALE dependencies
apt-get install libsdl1.2-dev libsdl-gfx1.2-dev libsdl-image1.2-dev cmake -y

#build ALE
mkdir build && cd build
cmake -DUSE_SDL=ON -DUSE_RLGLUE=OFF -DBUILD_EXAMPLES=ON ..
make -j 4

#set up python interface
cd ..
pip install .

#compile Java agents
cd doc/java-agent/code
ant jar

#run sample simulation
cd ../../..
cd doc/examples
./sharedLibraryInterfaceWithModesExample ../../roms/boxing.bin

