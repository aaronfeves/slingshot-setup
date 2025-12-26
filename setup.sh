#!/bin/bash
trap "exit" INT 
clear
echo "=========================================================="
echo "          SLINGSHOT TRADING SERVER INSTALLER"
echo "=========================================================="
echo "Initializing environment... please wait."

# 1. FORCE UPDATE: This deletes the old image so the user gets V1.6
echo ">>> Checking for software updates..."
docker rmi -f aaronfeves/slingshot-installer:latest > /dev/null 2>&1

# 2. PULL FRESH IMAGE
docker pull aaronfeves/slingshot-installer:latest

# 3. RUN INSTALLER
docker run -it --rm \
  -e CLOUDSDK_CORE_PROJECT=$(gcloud config get-value project 2>/dev/null) \
  aaronfeves/slingshot-installer:latest

# 4. SMART CLEANUP
echo ""
echo ">>> Performing cleanup..."
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$HOME"
rm -rf "$PROJECT_DIR"

echo ">>> Deployment finished. Returning to home prompt..."
exec bash
