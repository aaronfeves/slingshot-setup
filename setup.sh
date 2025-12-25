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

# --- Smart Cleanup Section ---
echo ">>> Performing thorough cleanup..."

rm ~/README-cloudshell.txt

# 1. Get the path of the specific project folder we are in
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# 2. Get the path of the parent 'cloudshell_open' folder
PARENT_DIR="$(dirname "$PROJECT_DIR")"

# 3. Move up so we aren't "using" the folder we are about to delete
cd "$HOME"

# 4. Delete the specific project folder (e.g., slingshot-setup-2)
rm -rf "$PROJECT_DIR"

# 5. Check if the parent 'cloudshell_open' folder is now empty
# If it's empty (aside from . and ..), delete it to keep things pristine
if [ -d "$PARENT_DIR" ] && [ "$(ls -A "$PARENT_DIR" 2>/dev/null)" = "" ]; then
    rmdir "$PARENT_DIR"
    echo ">>> Cleanup complete: Project and empty parent folder removed."
else
    echo ">>> Cleanup complete: Project removed (parent folder still contains other items)."
fi
