log_file=$1

#test if aptitude exists and default to using that if possible
if command -v aptitude >/dev/null 2>&1 ; then
  pm="aptitude"
else
  pm="apt-get"
fi

echo -e "\nUsing $pm for package installation\n"

sudo apt-get install jetty --force-yes

echo -e "\nConfiguring Jetty..."

sudo sh -c "cat > /etc/default/jetty" << EOF
JAVA_HOME=/usr/java/default # Path to Java
NO_START=0 # Start on boot
JETTY_HOST=0.0.0.0 # Listen to all hosts
JETTY_PORT=8085 # Run on this port
JETTY_USER=jetty # Run as this user
EOF