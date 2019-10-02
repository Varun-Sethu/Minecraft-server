#!/bin/bash


RED='\033[0;31m'


if [ `whoami` != root ]; then
    printf "${RED}PLEASE RUN THIS SCRIPT AS SUPER USER :)${RED}\n"
    exit
fi



if ! screen -list | grep -q "minecraft"; then
    cd $HOME/minecraft
    screen -S minecraft -d -m java -jar papermc.jar nogui 
fi
