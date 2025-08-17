#!/bin/bash
# Deployment and setup script for Raspberry Pi

set -e

echo "Volan - Raspberry Pi Deployment Script"
echo "======================================"

# Check if running on Raspberry Pi
if ! grep -q "Raspberry Pi" /proc/cpuinfo 2>/dev/null && ! grep -q "BCM" /proc/cpuinfo 2>/dev/null; then
    echo "Warning: This doesn't appear to be a Raspberry Pi"
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Install dependencies
echo "Installing dependencies..."
sudo apt update
sudo apt install -y \
    build-essential \
    cmake \
    git \
    qt6-base-dev \
    qt6-declarative-dev \
    qt6-serialbus-dev \
    qt6-tools-dev \
    qt6-tools-dev-tools \
    libqt6serialbus6-dev \
    libqt6quick6 \
    qml6-module-qtquick \
    qml6-module-qtquick-layouts \
    qml6-module-qtquick-controls \
    can-utils

# Enable SPI if not already enabled (needed for MCP2515)
echo "Checking SPI configuration..."
if ! grep -q "dtparam=spi=on" /boot/config.txt; then
    echo "Enabling SPI..."
    echo "dtparam=spi=on" | sudo tee -a /boot/config.txt
    SPI_ENABLED=1
fi

# Configure MCP2515 CAN interface if not already configured
echo "Checking CAN interface configuration..."
if ! grep -q "dtoverlay=mcp2515" /boot/config.txt; then
    echo "Configuring MCP2515 CAN interface..."
    echo "dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=25" | sudo tee -a /boot/config.txt
    CAN_CONFIGURED=1
fi

# Create CAN interface setup script
echo "Creating CAN setup script..."
sudo tee /usr/local/bin/setup-can.sh << 'EOF'
#!/bin/bash
# CAN interface setup script

echo "Setting up CAN interface..."
sudo modprobe can
sudo modprobe can_raw
sudo modprobe mcp251x

# Configure CAN interface
sudo ip link set can0 down 2>/dev/null || true
sudo ip link set can0 up type can bitrate 1000000
sudo ifconfig can0 txqueuelen 65536
sudo ifconfig can0 up

if ip link show can0 | grep -q "UP"; then
    echo "CAN interface can0 is up and configured"
    echo "Bitrate: 1000000"
else
    echo "Failed to configure CAN interface"
    exit 1
fi
EOF

sudo chmod +x /usr/local/bin/setup-can.sh

# Build the application
echo "Building Volan application..."
if [ -f "build-rpi.sh" ]; then
    ./build-rpi.sh
else
    echo "Build script not found. Building manually..."
    mkdir -p build
    cd build
    cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local
    make -j$(nproc)
    sudo make install
    cd ..
fi

# Create systemd service for auto-start
echo "Creating systemd service..."
sudo tee /etc/systemd/system/volan.service << EOF
[Unit]
Description=Volan CAN Dashboard
After=graphical-session.target network.target
Wants=graphical-session.target

[Service]
Type=simple
User=pi
Group=pi
Environment=DISPLAY=:0
Environment=XDG_RUNTIME_DIR=/run/user/1000
ExecStartPre=/usr/local/bin/setup-can.sh
ExecStart=/usr/local/bin/appvolan
Restart=always
RestartSec=5

[Install]
WantedBy=graphical-session.target
EOF

# Enable service (but don't start it yet)
sudo systemctl daemon-reload
sudo systemctl enable volan.service

# Create desktop entry
echo "Creating desktop entry..."
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/volan.desktop << EOF
[Desktop Entry]
Name=Volan CAN Dashboard
Comment=Vehicle CAN bus monitoring dashboard
Exec=/usr/local/bin/appvolan
Icon=applications-engineering
Terminal=false
Type=Application
Categories=Utility;System;
EOF

# Summary
echo ""
echo "Deployment completed successfully!"
echo ""

if [ "${SPI_ENABLED:-0}" = "1" ] || [ "${CAN_CONFIGURED:-0}" = "1" ]; then
    echo "⚠️  REBOOT REQUIRED ⚠️"
    echo "Hardware configuration was updated. Please reboot before using the application:"
    echo "  sudo reboot"
    echo ""
fi

echo "Usage:"
echo "  Manual start:     /usr/local/bin/appvolan"
echo "  Setup CAN:        /usr/local/bin/setup-can.sh"
echo "  Start service:    sudo systemctl start volan.service"
echo "  Enable auto-start: sudo systemctl enable volan.service"
echo ""
echo "Testing:"
echo "  Check CAN:        candump can0"
echo "  Send test frame:  cansend can0 BA5#64321001FFFFFFFF"
echo ""