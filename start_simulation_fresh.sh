#!/bin/sh

#run sample simulation
cd doc/examples
rm twoPlayerAI
make twoPlayerAI
./twoPlayerAI ../../roms/boxing.bin

