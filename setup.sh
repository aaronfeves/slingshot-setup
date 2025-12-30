#!/bin/bash
# ==========================================================
# SLINGSHOT MAGIC LINK BOOTSTRAPPER
# ==========================================================
VERSION="v1.6.32"

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


# 2. After the container closes, the host (Cloud Shell) does the cleanup
echo ">>> Container exited. Performing host-side cleanup..."

# Remove the image to save your 5GB Cloud Shell space
docker rmi aaronfeves/slingshot-installer:v1.6.32 --force

# Remove the temporary files if they exist
cd ~/
rm -rf ~/cloudshell_open

echo ">>> All clean. Deployment complete."
