#!/bin/bash
clear
echo "=========================================================="
echo "          SLINGSHOT TRADING SERVER INSTALLER"
echo "=========================================================="
echo "UPDATING TO VERSION V1.6.10..."

# Pull the specific version to ensure we bypass any 'latest' cache issues
docker pull aaronfeves/slingshot-installer:v1.6.10

echo ">>> Launching Installer..."
docker run -it --rm \
  -e CLOUDSDK_CORE_PROJECT=$(gcloud config get-value project) \
  aaronfeves/slingshot-installer:v1.6.10

clear
echo "Slingshot session ended."
