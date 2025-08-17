# Volan - CAN Bus Vehicle Dashboard

A Qt6/QML application for monitoring vehicle CAN bus data including battery percentage, battery temperature, and speed. Designed for fullscreen dashboard use on Raspberry Pi.

## Features

- Real-time CAN bus monitoring
- Battery percentage display
- Battery temperature monitoring  
- Speed display
- Error logging and display
- Fullscreen dashboard interface

## Prerequisites

### For Raspberry Pi Compilation

#### System Requirements
- Raspberry Pi 3B+ or newer (ARM64 recommended)
- Raspberry Pi OS (64-bit recommended)
- At least 2GB RAM
- 8GB+ SD card
- CAN bus interface (e.g., MCP2515 module)

#### Dependencies

**On Raspberry Pi:**
```bash
# Update system
sudo apt update && sudo apt upgrade -y

# Install Qt6 and development tools
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
```

**For Cross-compilation (Ubuntu/Debian host):**
```bash
# Install cross-compilation tools
sudo apt install -y \
    build-essential \
    cmake \
    git \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu

# You'll also need Qt6 cross-compilation libraries
# See cross-compilation section below
```

## CAN Bus Hardware Setup

### Raspberry Pi CAN Interface

1. **Enable SPI** (if using MCP2515):
   ```bash
   sudo raspi-config
   # Navigate to: Interfacing Options > SPI > Enable
   ```

2. **Configure MCP2515** (add to `/boot/config.txt`):
   ```
   dtoverlay=mcp2515-can0,oscillator=16000000,interrupt=25
   dtoverlay=spi1-3cs
   ```

3. **Reboot and verify**:
   ```bash
   sudo reboot
   # After reboot:
   ip link show can0
   ```

## Compilation

### Method 1: Direct Compilation on Raspberry Pi

```bash
# Clone repository
git clone https://github.com/domeepc/volan.git
cd volan

# Create build directory
mkdir build
cd build

# Configure with CMake
cmake .. -DCMAKE_BUILD_TYPE=Release

# Compile
make -j$(nproc)

# Install (optional)
sudo make install
```

### Method 2: Cross-compilation (Advanced)

For cross-compilation from Ubuntu/Debian to Raspberry Pi:

```bash
# Set up cross-compilation toolchain
export CC=aarch64-linux-gnu-gcc
export CXX=aarch64-linux-gnu-g++

# Clone repository
git clone https://github.com/domeepc/volan.git
cd volan

# Create build directory
mkdir build-rpi
cd build-rpi

# Configure for cross-compilation
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_SYSTEM_NAME=Linux \
    -DCMAKE_SYSTEM_PROCESSOR=aarch64 \
    -DCMAKE_C_COMPILER=aarch64-linux-gnu-gcc \
    -DCMAKE_CXX_COMPILER=aarch64-linux-gnu-g++ \
    -DCMAKE_FIND_ROOT_PATH=/path/to/rpi/sysroot \
    -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
    -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
    -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY

# Compile
make -j$(nproc)
```

**Note:** Cross-compilation requires setting up a Raspberry Pi sysroot with Qt6 libraries. This is advanced and direct compilation on Pi is recommended for most users.

## Usage

### 1. Set up CAN interface

```bash
# Configure CAN interface (adjust bitrate as needed)
sudo ip link set can0 up type can bitrate 1000000
sudo ifconfig can0 txqueuelen 65536
sudo ifconfig can0 up

# Verify CAN interface is up
ip link show can0
```

### 2. Run the application

```bash
# From build directory
./appvolan

# Or if installed system-wide
/usr/local/bin/appvolan
```

### 3. Monitor CAN traffic (optional)

```bash
# View all CAN frames
candump can0

# Filter for specific frames
candump can0,BA5:7FF  # Battery data
candump can0,BE4:7FF  # Speed data
```

## CAN Protocol

The application monitors these CAN frame IDs:

- **0xBA5**: Battery data (8 bytes)
  - Byte 1: Battery percentage (0-100%)
  - Byte 2: Battery temperature (°C)
  - Bytes 3-8: Reserved

- **0xBE4**: Speed data (8 bytes)
  - Byte 1: Speed (km/h)
  - Bytes 2-8: Reserved

## Troubleshooting

### Common Issues

1. **Qt6 not found:**
   ```bash
   # Verify Qt6 installation
   qmake6 --version
   # or
   /usr/lib/qt6/bin/qmake --version
   ```

2. **CAN interface not found:**
   ```bash
   # Check if CAN modules are loaded
   lsmod | grep can
   
   # Load CAN modules manually if needed
   sudo modprobe can
   sudo modprobe can_raw
   sudo modprobe mcp251x
   ```

3. **Permission denied on CAN interface:**
   ```bash
   # Add user to dialout group
   sudo usermod -a -G dialout $USER
   # Logout and login again
   ```

4. **Display issues on Pi:**
   ```bash
   # Ensure X11 forwarding or run on Pi desktop
   export DISPLAY=:0
   ```

### Debug Mode

To run with debug output:
```bash
QT_LOGGING_RULES="*.debug=true" ./appvolan
```

## Performance Optimization for Raspberry Pi

### GPU Memory Split
```bash
# Increase GPU memory for better Qt performance
sudo raspi-config
# Advanced Options > Memory Split > 128
```

### Disable Unnecessary Services
```bash
# Disable unused services for better performance
sudo systemctl disable bluetooth
sudo systemctl disable avahi-daemon
```

## Auto-start on Boot

To automatically start the application on boot:

1. Create systemd service:
   ```bash
   sudo tee /etc/systemd/system/volan.service << EOF
   [Unit]
   Description=Volan CAN Dashboard
   After=graphical-session.target
   
   [Service]
   Type=simple
   User=pi
   Environment=DISPLAY=:0
   ExecStartPre=/bin/bash -c 'sudo ip link set can0 up type can bitrate 1000000 || true'
   ExecStart=/usr/local/bin/appvolan
   Restart=always
   
   [Install]
   WantedBy=graphical-session.target
   EOF
   ```

2. Enable service:
   ```bash
   sudo systemctl enable volan.service
   sudo systemctl start volan.service
   ```

## Development

### Building with Debug Info
```bash
cmake .. -DCMAKE_BUILD_TYPE=Debug
make -j$(nproc)
```

### Code Structure
- `main.cpp`: Application entry point
- `back.h/back.cpp`: CAN bus backend logic
- `Main.qml`: QML user interface

## License

See LICENSE file for details.
