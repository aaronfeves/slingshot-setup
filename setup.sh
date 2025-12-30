#!/bin/bash
# ==========================================================
# SLINGSHOT MAGIC LINK BOOTSTRAPPER
# ==========================================================
VERSION="v1.6.31"

echo "=========================================================="
echo "          SLINGSHOT TRADING SERVER INSTALLER"
echo "=========================================================="
echo "UPDATING TO VERSION $VERSION..."

# 1. Force-pull the latest image to bypass local cache
docker pull aaronfeves/slingshot-installer:$VERSION

# 2. Cleanup any 'none' (dangling) images to keep Cloud Shell clean
docker image prune -f > /dev/null 2>&1

echo ">>> Launching Installer..."

# 3. Run the installer
docker run -it --rm \
  -v "$HOME/.config/gcloud:/root/.config/gcloud" \
  aaronfeves/slingshot-installer:$VERSION
