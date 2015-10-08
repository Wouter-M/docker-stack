#!/bin/bash -e
if [ "$(id -u)" != "0" ]; then
	echo "$(tput setaf 1)$(tput bold)Error: $(tput sgr0)$(tput setaf 1)You need to be root in order to use this install script."
	exit 1
fi

# TODO: find a friendlier language to write this in

echo $(tput sgr0)$(tput bold)Installing Docker...$(tput sgr0)

echo -e "\tAdding GPG key..."$(tput setaf 6)
# All commands piped to sed for indentation
apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D | sed 's/^/\t/'
echo -e $(tput sgr0)"\tAdding docker software repository source..."$(tput setaf 6)
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list | sed 's/^/\t/'
echo -e $(tput sgr0)"\tUpdating apt..."$(tput setaf 6)
apt-get update | sed 's/^/\t/'
echo -e $(tput sgr0)"\tPurging old repo"$(tput setaf 6)
apt-get purge lxc-docker* | sed 's/^/\t/'
echo -e $(tput sgr0)"\tInstalling Docker engine..."$(tput setaf 6)
apt-get install -y docker-engine | sed 's/^/\t/'

echo $(tput sgr0)$(tput bold)Installing Docker Compose...$(tput sgr0)
echo -e $(tput sgr0)"\tGetting binary..."$(tput setaf 6)
curl -L https://github.com/docker/compose/releases/download/1.4.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose | sed 's/^/\t/'
echo -e $(tput sgr0)"\tSetting execute permission..."$(tput setaf 6)
chmod +x /usr/local/bin/docker-compose | sed 's/^/\t/'

echo $(tput sgr0)$(tput bold)"Installing Weave (for networking)..."$(tput sgr0)
curl -L https://git.io/weave -o /usr/local/bin/weave | sed 's/^/\t/'
echo -e $(tput sgr0)"\tSetting execute permission..."$(tput setaf 6)
chmod a+x /usr/local/bin/weave | sed 's/^/\t/'
echo -e $(tput sgr0)"\tRunning Weave so it pulls the images..."$(tput setaf 6)
weave | sed 's/^/\t/'
echo -e  $(tput sgr0)$(tput setaf 3)"\tDo not forget to connect weave to the woven network!"$(tput sgr0)

printf $(tput sgr0)

