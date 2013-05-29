log_file=$1

#test if aptitude exists and default to using that if possible
if command -v aptitude >/dev/null 2>&1 ; then
  pm="aptitude"
else
  pm="apt-get"
fi

echo -e "\nUsing $pm for package installation\n"

# Install MariaDB
echo -e "\n=> Installing MariaDB (MySQL)..."
sudo apt-get install python-software-properties --force-yes
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
sudo add-apt-repository 'deb http://ftp.osuosl.org/pub/mariadb/repo/10.0/ubuntu precise main'
sudo apt-get update
sudo apt-get install mariadb-server --force-yes

echo "==> done..."