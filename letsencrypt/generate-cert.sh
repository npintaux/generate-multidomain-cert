#!/bin/bash

# Exit on error
set -e

echo "This script generates a LetsEncrypt certificate, using the 'certbot' utility."

echo "Prerequisites:"
echo "--------------"
echo "  1. the utility 'certbot' must be installed, as well as the certbot-dns-google plugin.'"
echo "  1. a DNS zone set up on Google Cloud Platform. The proper NS records must be set on the DNS of your registrar."
echo "  2. a GCP Credentials file, which needs to be located in ${HOME}/workspace/iaas-credentials/gcp_credentials.json."
echo "	3. a known list of subdomains to validate. There should be a DNS zone already created in GCP."
echo
echo "The process itself takes less than 2 minutes. It generates PEM files locally, and does not install the certificate on any web server."
echo

echo "Checking prerequisites..."
hash certbot &> /dev/null
if [ $? -eq 1 ]; then
    ./install-certbot.sh
fi

FILE=${HOME}/workspace/iaas-credentials/gcp_credentials.json
if [ -f "$FILE" ]; then
    echo "$FILE exist"
else 
    echo "$FILE does not exist. Please provide a valid credentials file for the GCP platform."
    exit 1
fi


read -p "Please provide an e-mail to register the 'certbot' client. This will allow you to manage your certificates: " CERT_EMAIL
read -p "Please enter the list of subdomains you want to add to your certificate: " CERT_SUBDOMAINS
read -p "Please enter the full path to your GCP Credentials file: " GCP_CREDENTIALS_FILE

echo

echo "Generating certificate for domain ${GCP_DNS_ZONE}"
sudo certbot --agree-tos -m ${CERT_EMAIL} \
        certonly \
        --dns-google -n \
        -d "${CERT_SUBDOMAINS}" \
        --dns-google-credentials=${GCP_CREDENTIALS_FILE} --dns-google-propagation-seconds 60
