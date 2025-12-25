#!/bin/bash
clear
echo "=========================================================="
echo "          SLINGSHOT TRADING SERVER INSTALLER"
echo "=========================================================="
echo "Initializing environment... please wait."

# 0. Kill everything on Control-C immediately
trap "exit" INT 


# 1. Force the latest image pull
# This ensures users get the V1.4 Project Validation logic even if they have a cached image
docker pull aaronfeves/slingshot-installer:latest

# 2. Run the Installer
# We pass the current Project ID if it exists to help the container authenticate
docker run -it --rm \
  -e CLOUDSDK_CORE_PROJECT=$(gcloud config get-value project 2>/dev/null) \
  aaronfeves/slingshot-installer:latest

# 3. Smart Cleanup Section
echo ""
echo ">>> Performing thorough cleanup..."

# Identify the project folder and its parent (cloudshell_open)
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$PROJECT_DIR")"

# Move to the home directory so we can safely delete the current folder
cd "$HOME"

# Delete the specific project folder cloned from GitHub
rm -rf "$PROJECT_DIR"

# If 'cloudshell_open' is now empty, remove it to keep the home directory pristine
if [ -d "$PARENT_DIR" ] && [ "$(ls -A "$PARENT_DIR" 2>/dev/null)" = "" ]; then
    rmdir "$PARENT_DIR"
    echo ">>> Cleanup complete: Project and empty parent folder removed."
else
    echo ">>> Cleanup complete: Project removed."
fi

echo ">>> Deployment finished. Returning you to the home prompt..."

# 4. Refresh the shell to land the user back at the ~/ prompt
exec bash
