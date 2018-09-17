#!/bin/bash

cd

function root_install {
        apt-get update

        apt-get install -y \
                curl \
                vim \
                screen \
                htop \
                ntp \
                git \


        # Docker
        apt-get install -y \
                apt-transport-https \
                ca-certificates \
                software-properties-common

        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

        apt-key fingerprint 0EBFCD88

        add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

        apt-get install -y docker-ce
        groupadd dockers
        gpasswd -a olivier docker
        service docker restart
}

function curl_dotfiles {
	curl \
	        -O https://raw.githubusercontent.com/olivierperez/dotfiles/master/files/.aliases.docker \
	        -O https://raw.githubusercontent.com/olivierperez/dotfiles/master/files/.aliases.global \
	        -O https://raw.githubusercontent.com/olivierperez/dotfiles/master/files/.bashps1 \
	        -O https://raw.githubusercontent.com/olivierperez/dotfiles/master/files/.gitconfig \
	        -O https://raw.githubusercontent.com/olivierperez/dotfiles/master/files/.screenrc \
	        -O https://raw.githubusercontent.com/olivierperez/dotfiles/master/files/.vimrc

	echo ". ~/.aliases.global" >> ~/.bashrc
	echo ". ~/.aliases.docker" >> ~/.bashrc
}

cd

if [ "$(id -u)" != "0" ]; then

        echo "------------------------------------------"
        echo "You need to be root to do the full install"
        echo "------------------------------------------"

        curl_dotfiles


else

        echo "------------------"
        echo "Installing as root"
        echo "------------------"

        root_install
        curl_dotfiles

fi

echo "---------------------"
echo "Installation finished"
echo "---------------------"

