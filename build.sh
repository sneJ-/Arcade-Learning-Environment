#!/bin/bash

if [ $1 == "-i" ]
then
	#install main ALE dependencies
	sudo add-apt-repository universe 
	sudo apt-get install libsdl1.2-dev libsdl-gfx1.2-dev libsdl-image1.2-dev cmake python-pip -y

	#install dqn dependencies
	sudo -H pip install petname imageio
	export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-0.11.0rc0-cp27-none-linux_x86_64.whl
	sudo -H pip install --upgrade $TF_BINARY_URL
fi

#build ALE
mkdir build && cd build
sudo cmake -DUSE_SDL=ON -DUSE_RLGLUE=OFF -DBUILD_EXAMPLES=ON ..
sudo make -j 4

#set up python interface
cd ..
sudo -H pip install .

#compile Java agents
cd doc/java-agent/code
ant jar

#run sample simulation
cd ../../..
cd doc/examples
make twoPlayerAI
./twoPlayerAI ../../roms/boxing.bin


