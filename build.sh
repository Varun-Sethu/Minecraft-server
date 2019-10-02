#!/bin/bash

GIT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd $HOME
mkdir -p minecraft
cd minecraft

GREEN='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m'


# Check that script was run with sudo
if [ `whoami` != root ]; then
    printf "${RED}PLEASE RUN THIS SCRIPT AS SUPER USER :)${RED}\n"
    exit
fi





# Downlaod and set up jdk
if ! type "java" > /dev/null; then
    printf "${GREEN}Downloading and setting up JDK${NC}\n\n\n\n\n"

    wget -O jdk.tar.gz -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/13+33/5b8a42f3905b406298b72d750b6919f6/jdk-13_linux-x64_bin.tar.gz
    tar -xzvf jdk.tar.gz --directory /usr/local
    JAVA_HOME=/usr/local/jdk-13
    echo "export JAVA_HOME=${JAVA_HOME}" >> $HOME/.bashrc
    echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> $HOME/.bashrc
    source $HOME/.bashrc
    
    # clean up
    rm jdk.tar.gz

    printf "${RED}Finishined${GREEN} Downloading and setting up JDK\n\n\n\n\n"
fi






# Download and set up papermc
printf "${GREEN}Downloading and setting up PaperMC${NC}\n\n\n\n\n"

wget -O papermc.jar https://papermc.io/ci/job/Paper-1.14/lastSuccessfulBuild/artifact/paperclip-207.jar
java -jar papermc.jar
java -jar papermc.jar nogui

if ! type "start-minecraft" > /dev/null; then
    cp $GIT_DIR/start-minecraft.sh $HOME/minecraft/start-minecraft
    chmod +x $HOME/minecraft/start-minecraft
    echo "export PATH=\$PATH:${HOME}/minecraft/start-minecraft" >> $HOME/.bashrc
fi

# Bit of a hack :P
while [tail -1 $HOME/minecraft/eula.txt = "eula=false"]
do
    printf "${RED} You need to agree to the EULA${NC}"
    vim $HOME/minecraft/eula.txt
done

java -jar -Xms512M -Xmx1008M papermc.jar nogui

printf "${RED}Finishined${GREEN} Downloading and setting up PaperMC\n\n\n\n\n"





