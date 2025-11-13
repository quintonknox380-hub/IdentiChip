#!/bin/bash

# Script to install usbutils, wireless-tools, and bluez packages

echo "======================================"
echo "Package Installation Script"
echo "======================================"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "This script requires sudo privileges."
    echo "You may be prompted for your password."
    echo ""
fi

# Update package lists
echo "Updating package lists..."
sudo apt update

if [ $? -ne 0 ]; then
    echo "Error: Failed to update package lists."
    exit 1
fi

echo ""
echo "======================================"
echo "Installing packages..."
echo "======================================"

# Array of packages to install
PACKAGES=("usbutils" "wireless-tools" "bluez")

# Install each package
for pkg in "${PACKAGES[@]}"; do
    echo ""
    echo "Installing $pkg..."
    sudo apt install -y "$pkg"
    
    if [ $? -eq 0 ]; then
        echo "✓ $pkg installed successfully"
    else
        echo "✗ Failed to install $pkg"
    fi
done

echo ""
echo "======================================"
echo "Installation complete!"
echo "======================================"
echo ""

# Display installed versions
echo "Installed package versions:"
echo ""
dpkg -l | grep -E "usbutils|wireless-tools|bluez" | awk '{print $2, $3}'

echo ""
echo "Useful commands:"
echo "  lsusb           - List USB devices (from usbutils)"
echo "  iwconfig        - Configure wireless interfaces (from wireless-tools)"
echo "  bluetoothctl    - Bluetooth control utility (from bluez)"
