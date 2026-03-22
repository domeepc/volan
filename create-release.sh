#!/bin/bash
# Release packaging script

set -e

VERSION="0.1.0"
ARCH="x86_64"
BUILD_DIR="build"
RELEASE_DIR="releases"
PACKAGE_NAME="volan-${VERSION}-${ARCH}"

echo "Creating release package: $PACKAGE_NAME"

# Ensure build directory exists and binary is built
if [ ! -f "$BUILD_DIR/appvolan" ]; then
    echo "Error: Binary not found. Please build first with:"
    echo "  mkdir build && cd build && cmake .. && make"
    exit 1
fi

# Create release directory structure
mkdir -p "$RELEASE_DIR/$PACKAGE_NAME"
cd "$RELEASE_DIR/$PACKAGE_NAME"

# Copy binary
cp "../../$BUILD_DIR/appvolan" ./

# Copy documentation
cp "../../README.md" ./
cp "../../LICENSE" ./

# Copy build scripts
cp "../../build-rpi.sh" ./
cp "../../build-cross.sh" ./
cp "../../deploy-rpi.sh" ./

# Copy source files for reference
mkdir -p src
cp -r "../../src/." src/
cp "../../CMakeLists.txt" src/

# Create installation script
cat > install.sh << 'EOF'
#!/bin/bash
# Installation script for Volan

echo "Installing Volan CAN Dashboard..."

# Copy binary to system location
sudo cp appvolan /usr/local/bin/
sudo chmod +x /usr/local/bin/appvolan

# Create desktop entry
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/volan.desktop << DESKTOP_EOF
[Desktop Entry]
Name=Volan CAN Dashboard
Comment=Vehicle CAN bus monitoring dashboard
Exec=/usr/local/bin/appvolan
Icon=applications-engineering
Terminal=false
Type=Application
Categories=Utility;System;
DESKTOP_EOF

echo "Installation completed!"
echo "Run with: /usr/local/bin/appvolan"
EOF

chmod +x install.sh

# Create startup script for Raspberry Pi
cat > start-volan.sh << 'EOF'
#!/bin/bash
# Startup script for Volan on Raspberry Pi

# Setup CAN interface
echo "Setting up CAN interface..."
sudo modprobe can can_raw mcp251x
sudo ip link set can0 down 2>/dev/null || true
sudo ip link set can0 up type can bitrate 1000000
sudo ifconfig can0 txqueuelen 65536
sudo ifconfig can0 up

# Check if CAN interface is up
if ! ip link show can0 | grep -q "UP"; then
    echo "Warning: CAN interface failed to start"
    echo "Make sure MCP2515 is properly configured in /boot/config.txt"
fi

# Set display for X11
export DISPLAY=:0

# Start application
echo "Starting Volan..."
/usr/local/bin/appvolan
EOF

chmod +x start-volan.sh

# Create README for the release
cat > RELEASE_README.md << 'EOF'
# Volan Release Package

This package contains the compiled Volan CAN Dashboard application.

## Contents

- `appvolan` - Main executable binary
- `install.sh` - System installation script  
- `start-volan.sh` - Startup script for Raspberry Pi
- `build-rpi.sh` - Build script for Raspberry Pi
- `build-cross.sh` - Cross-compilation script
- `deploy-rpi.sh` - Full deployment script for Raspberry Pi
- `src/` - Source code files
- `README.md` - Full documentation
- `LICENSE` - License information

## Quick Start on Raspberry Pi

1. Extract this package to your Raspberry Pi
2. Run the deployment script: `sudo ./deploy-rpi.sh`
3. Reboot if prompted
4. Run: `./start-volan.sh`

## Manual Installation

1. Run: `./install.sh`
2. Set up CAN interface as described in README.md
3. Run: `/usr/local/bin/appvolan`

## Building from Source

See README.md for detailed compilation instructions.

For Raspberry Pi: `./build-rpi.sh`
For cross-compilation: `./build-cross.sh`
EOF

# Go back to original directory
cd ../..

# Create compressed package
echo "Creating compressed package..."
cd "$RELEASE_DIR"
tar -czf "${PACKAGE_NAME}.tar.gz" "$PACKAGE_NAME"
zip -r "${PACKAGE_NAME}.zip" "$PACKAGE_NAME" > /dev/null

# Calculate checksums
echo "Calculating checksums..."
sha256sum "${PACKAGE_NAME}.tar.gz" > "${PACKAGE_NAME}.tar.gz.sha256"
sha256sum "${PACKAGE_NAME}.zip" > "${PACKAGE_NAME}.zip.sha256"

cd ..

echo "Release package created successfully!"
echo "Files created:"
echo "  $RELEASE_DIR/${PACKAGE_NAME}.tar.gz"
echo "  $RELEASE_DIR/${PACKAGE_NAME}.zip"
echo "  $RELEASE_DIR/${PACKAGE_NAME}/ (directory)"
echo ""
echo "Package size:"
ls -lh "$RELEASE_DIR/${PACKAGE_NAME}.tar.gz" "$RELEASE_DIR/${PACKAGE_NAME}.zip"