
#!/bin/bash

# Check current user
CURRENT_USER=$(whoami)
echo "Current user: $CURRENT_USER"

# Get current working directory
CURRENT_DIR=$(pwd)
echo "Current working directory: $CURRENT_DIR"

# Check if current directory is /home/user/
if [ "$CURRENT_DIR" = "/home/$CURRENT_USER" ]; then
    echo "Confirmed: Working directory is /home/$CURRENT_USER/"
    
    # Define target directory
    TARGET_DIR="/home/$CURRENT_USER/IdentiChip"
    
    # Create directory if it doesn't exist
    if [ ! -d "$TARGET_DIR" ]; then
        echo "Creating directory: $TARGET_DIR"
        mkdir -p "$TARGET_DIR"
    else
        echo "Directory already exists: $TARGET_DIR"
    fi
    
    # Set full read/write/execute permissions for all users (777)
    echo "Setting permissions to 777 (full access for all users)..."
    chmod 777 "$TARGET_DIR"
    
    # Change to the target directory
    cd "$TARGET_DIR" || exit 1
    echo "Changed directory to: $(pwd)"
    
    # Verify permissions
    echo "Directory permissions: $(ls -ld "$TARGET_DIR")"
    
else
    echo "Error: Current directory is not /home/$CURRENT_USER/"
    echo "Please navigate to /home/$CURRENT_USER/ before running this script."
    exit 1
fi

#!/bin/bash

# Script to install usbutils, wireless-tools, and bluez packages
echo "======================================"
echo "Package Installation Script"
echo "======================================"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Oops This script requires sudo privileges."
    echo "You may be prompted for your password."
    echo ""
fi

# Update package lists
echo "Busy Updating package lists..."
sudo apt update

if [ $? -ne 0 ]; then
    echo "Error: Failed to update package lists."
    exit 1
fi

echo ""
echo "======================================"
echo "Just Installing packages quick..."
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
echo "Yeah Installation complete!"
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

