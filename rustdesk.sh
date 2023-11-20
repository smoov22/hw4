# Script by Vaughn Woerpel

#!/bin/bash

if [[ $(/usr/bin/id -u) -ne 0 ]]; then
    echo "Script must be run as root: ex: sudo ./install-rustdesk.sh {password}"
    exit
fi

if [ $# -eq 0 ]
  then
    echo "Please supply a password: ex: sudo ./install-rustdesk.sh {password}"
    exit
fi


# Download the deb and install it
echo "=== Installing Rustdesk... ==="
url="https://github.com/rustdesk/rustdesk/releases/download/1.2.3/rustdesk-1.2.3-x86_64.deb"
wget -O rustdesk.deb $url
dpkg -i rustdesk.deb

# Make the symlink and set up the service
echo "=== Setting up Rustdesk... ==="
ln -s /usr/lib/rustdesk/rustdesk /usr/bin/rustdesk
cp /usr/share/rustdesk/files/systemd/rustdesk.service /etc/systemd/system/rustdesk.service

echo "custom-rendezvous-server = 'rustdesk.cyberrange.rit.edu'" >> /root/.config/rustdesk/RustDesk2.toml
echo "relay-server = 'rustdesk.cyberrange.rit.edu'" >> /root/.config/rustdesk/RustDesk2.toml
echo "verification-method = 'use-permanent-password'" >> /root/.config/rustdesk/RustDesk2.toml

# Set the password
rustdesk --password $1
echo "Set password to $1"

# Get the ID
echo "Client ID:"
rustdesk --get-id

# Enable the service
systemctl enable rustdesk
systemctl start rustdesk

rm rustdesk.deb
