#!/bin/bash

if [ "$1" == "-i" ]
then
	#install main ALE dependencies
	sudo add-apt-repository universe 
	sudo apt-get install libsdl1.2-dev libsdl-gfx1.2-dev libsdl-image1.2-dev cmake python-pip python-dev ant -y
	sudo -H pip install numpy
fi

#build ALE
if [ -d "build" ]; then
    cd build
else
    mkdir build && cd build
fi
sudo cmake -DUSE_SDL=ON -DUSE_RLGLUE=OFF -DBUILD_EXAMPLES=ON ..
sudo make -j 4

#set up python interface
cd ..
sudo -H pip install --upgrade --force-reinstall .

#compile Java agents
cd doc/java-agent/code
ant jar
