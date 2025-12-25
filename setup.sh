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

# --- Smart Cleanup & Return Home ---
echo ">>> Performing thorough cleanup..."

# 1. Identify paths
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$PROJECT_DIR")"

# 2. Move to the actual Home directory
cd "$HOME"

# 3. Delete the specific project folder
rm -rf "$PROJECT_DIR"

# 4. Delete parent folder IF it is now empty
if [ -d "$PARENT_DIR" ] && [ "$(ls -A "$PARENT_DIR" 2>/dev/null)" = "" ]; then
    rmdir "$PARENT_DIR"
    echo ">>> Project and empty parent folder removed."
else
    echo ">>> Project removed (parent folder still in use)."
fi

echo ">>> Deployment finished. Returning you to the home prompt..."
# 5. Launch a new interactive shell at the Home directory
exec bash
