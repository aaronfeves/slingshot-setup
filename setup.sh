#!/bin/bash

# Clear the screen to provide a clean, professional interface
clear

echo "=========================================================="
echo "          SLINGSHOT TRADING SERVER INSTALLER"
echo "=========================================================="
echo "Initializing environment... please wait."
echo ""

# Launch the private Docker container with interactive flags
# This pulls your latest code, Terraform logic, and installers
docker run -it --rm \
  -e CLOUDSDK_CORE_PROJECT=$(gcloud config get-value project) \
  aaronfeves/slingshot-installer:latest

# Optional: Clear the screen again after the user exits the installer
clear
echo "Slingshot session ended."
