#!/bin/bash
clear
echo "=========================================================="
echo "          SLINGSHOT TRADING SERVER INSTALLER"
echo "=========================================================="
echo "Checking for software updates..."

# Force remove the old local image to ensure the fresh version is used
docker rmi -f aaronfeves/slingshot-installer:latest > /dev/null 2>&1

# Pull the fresh, verified V1.6.5 image
docker pull aaronfeves/slingshot-installer:latest

echo ">>> Launching Installer..."
docker run -it --rm \
  -e CLOUDSDK_CORE_PROJECT=$(gcloud config get-value project) \
  aaronfeves/slingshot-installer:latest

clear
echo "Slingshot session ended."
