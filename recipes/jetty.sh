log_file=$1

#test if aptitude exists and default to using that if possible
if command -v aptitude >/dev/null 2>&1 ; then
  pm="aptitude"
else
  pm="apt-get"
fi

echo -e "\nUsing $pm for package installation\n"

sudo apt-get install jetty

echo -e "\nConfiguring Jetty..."
sudo sed -i 's/^\(NO_START\s*=\s*\).*$/\10/' /etc/default/jetty
sudo sed -i '$a\JETTY_HOST=0.0.0.0' /etc/default/jetty