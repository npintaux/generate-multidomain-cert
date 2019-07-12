#!/bin/bash

echo "Installing certbot..."
sudo apt-get install certbot --yes
sudo apt-get install python-setuptools --yes
echo


echo "Installing 'certbot-dns-google' pluging for 'certbot'..."
git clone https://github.com/certbot/certbot.git
cd certbot/certbot-dns-google
sudo python setup.py install
echo