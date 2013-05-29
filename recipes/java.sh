log_file=$1

#test if aptitude exists and default to using that if possible
if command -v aptitude >/dev/null 2>&1 ; then
  pm="aptitude"
else
  pm="apt-get"
fi

echo -e "\nUsing $pm for package installation\n"

# Install Java 7
echo -e "\n=> Installing Open JDK 7..."
sudo apt-get install openjdk-7-jdk --force-yes
echo "==> done..."


