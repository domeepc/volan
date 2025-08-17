#!/bin/bash
# Build script for Raspberry Pi (direct compilation on Pi)

set -e

echo "Volan - Raspberry Pi Build Script"
echo "================================="

# Check if running on Raspberry Pi
if ! grep -q "Raspberry Pi" /proc/cpuinfo 2>/dev/null && ! grep -q "BCM" /proc/cpuinfo 2>/dev/null; then
    echo "Warning: This doesn't appear to be a Raspberry Pi"
    echo "This script is designed for direct compilation on Raspberry Pi"
    read -p "Continue anyway? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Check dependencies
echo "Checking dependencies..."
MISSING_DEPS=()

command -v cmake >/dev/null 2>&1 || MISSING_DEPS+=("cmake")
command -v make >/dev/null 2>&1 || MISSING_DEPS+=("build-essential")
command -v qmake6 >/dev/null 2>&1 || command -v /usr/lib/qt6/bin/qmake >/dev/null 2>&1 || MISSING_DEPS+=("qt6-base-dev")

if [ ${#MISSING_DEPS[@]} -ne 0 ]; then
    echo "Missing dependencies: ${MISSING_DEPS[*]}"
    echo "Please install them with:"
    echo "sudo apt update && sudo apt install -y build-essential cmake qt6-base-dev qt6-declarative-dev qt6-serialbus-dev qt6-tools-dev libqt6serialbus6-dev"
    exit 1
fi

# Create build directory
BUILD_DIR="build-rpi"
echo "Creating build directory: $BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Configure with CMake
echo "Configuring with CMake..."
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DCMAKE_CXX_STANDARD=17

# Build
echo "Building application..."
make -j$(nproc) || make -j1

# Check if binary was created
if [ -f "appvolan" ]; then
    echo "Build successful!"
    echo "Binary location: $(pwd)/appvolan"
    echo "Binary size: $(ls -lh appvolan | awk '{print $5}')"
    
    # Test if binary works
    echo "Testing binary..."
    if ldd appvolan > /tmp/volan_deps.txt 2>&1; then
        echo "Dependencies check passed"
        echo "Dependencies:"
        cat /tmp/volan_deps.txt | grep -E "(Qt|libstdc|libgcc)" | head -5
        rm -f /tmp/volan_deps.txt
    else
        echo "Warning: Could not check dependencies"
    fi
    
    echo ""
    echo "To install system-wide, run:"
    echo "  sudo make install"
    echo ""
    echo "To run the application:"
    echo "  1. Set up CAN interface: sudo ip link set can0 up type can bitrate 1000000"
    echo "  2. Run: ./appvolan"
    
else
    echo "Build failed - binary not found"
    exit 1
fi