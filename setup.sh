#!/bin/bash
clear
echo "=========================================================="
echo "          SLINGSHOT TRADING SERVER INSTALLER"
echo "=========================================================="
echo "FORCING VERSION UPDATE TO V1.6.8..."

# Pull the specific version tag
docker pull aaronfeves/slingshot-installer:v1.6.8

echo ">>> Launching Installer..."
docker run -it --rm \
  -e CLOUDSDK_CORE_PROJECT=$(gcloud config get-value project) \
  aaronfeves/slingshot-installer:v1.6.8

clear
echo "Slingshot session ended."
