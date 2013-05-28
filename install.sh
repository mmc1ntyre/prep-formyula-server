#!/bin/bash
#
# Prep-Formyula-Server
#
# Author: Michael McIntyre <michael@environmentalreports.com>
# Licence: MIT
#

shopt -s nocaseglob
set -e

script_runner=$(whoami)
root_path=$(cd && pwd)/prep-formyula-server
log_file="$root_path/install.log"
distro_sig=$(cat /etc/issue)
recipe_path="https://github.com/mmc1ntyre/prep-formyula-server/raw/master/recipes"

control_c()
{
  echo -en "\n\n*** Exiting ***\n\n"
  exit 1
}

# trap keyboard interrupt (control-c)
trap control_c SIGINT

echo -e "\n\n"
echo "
echo "  _____                                .__          "
echo "_/ ____\___________  _____ ___.__.__ __|  | _____   "
echo "\   __\/  _ \_  __ \/     <   |  |  |  \  | \__  \  "
echo " |  | (  <_> )  | \/  Y Y  \___  |  |  /  |__/ __ \_"
echo " |__|  \____/|__|  |__|_|  / ____|____/|____(____  /"
echo "                         \/\/                    \/"
echo -e "\n\n"

#now check if user is root
if [ $script_runner == "root" ] ; then
  echo -e "\nThis script must be run as a normal user with sudo privileges\n"
  exit 1
fi

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $script_runner has no sudo privileges ; exit 1; }

echo -e "\n=> Creating install dir..."
cd && mkdir -p prep-formyula-server/src && cd prep-formyula-server && touch install.log
echo "==> done..."

echo -e "\n=> Ensuring there is a .bashrc and .bash_profile..."
rm -f $HOME/.bashrc && rm -f $HOME/.bash_profile
touch $HOME/.bashrc && touch $HOME/.bash_profile
echo 'PS1="[\u@\h:\w] $ "' >> $HOME/.bashrc
echo "==> done..."

# Download Recipes
echo -e "\n=> Downloading Recipes for Installation...\n"
wget --no-check-certificate -O $prepserver_path/src/base.sh $recipe_path/base.sh
echo -e "\n==> done..."

cd $prep-formyula-server/src

# Base installation
echo -e "\n=> Performing Base Installation...\n"
bash base.sh $log_file
echo -e "\n==> done..."

echo -e "\n#################################"
echo    "### Installation is complete! ###"
echo -e "#################################\n"


