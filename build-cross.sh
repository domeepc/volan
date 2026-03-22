#!/bin/bash
# Cross-compilation script for Raspberry Pi (run on Ubuntu/Debian)

set -e

echo "Volan - Cross-compilation Script for Raspberry Pi"
echo "================================================"

# Configuration
TARGET_ARCH="aarch64"
TARGET_TRIPLET="aarch64-linux-gnu"
BUILD_DIR="build-cross-rpi"
SYSROOT_PATH="${SYSROOT_PATH:-/opt/rpi-sysroot}"

# Check if cross-compilation tools are available
echo "Checking cross-compilation tools..."
MISSING_TOOLS=()

command -v ${TARGET_TRIPLET}-gcc >/dev/null 2>&1 || MISSING_TOOLS+=("gcc-${TARGET_TRIPLET}")
command -v ${TARGET_TRIPLET}-g++ >/dev/null 2>&1 || MISSING_TOOLS+=("g++-${TARGET_TRIPLET}")
command -v cmake >/dev/null 2>&1 || MISSING_TOOLS+=("cmake")

if [ ${#MISSING_TOOLS[@]} -ne 0 ]; then
    echo "Missing cross-compilation tools: ${MISSING_TOOLS[*]}"
    echo "Please install them with:"
    echo "sudo apt update && sudo apt install -y build-essential cmake gcc-${TARGET_TRIPLET} g++-${TARGET_TRIPLET}"
    exit 1
fi

# Check for sysroot
if [ ! -d "$SYSROOT_PATH" ]; then
    echo "Warning: Sysroot not found at $SYSROOT_PATH"
    echo "Cross-compilation requires a Raspberry Pi sysroot with Qt6 libraries."
    echo "You can:"
    echo "1. Set up a sysroot manually"
    echo "2. Use direct compilation on Raspberry Pi instead (recommended)"
    echo "3. Set SYSROOT_PATH environment variable to your sysroot location"
    exit 1
fi

# Export toolchain variables
export CC=${TARGET_TRIPLET}-gcc
export CXX=${TARGET_TRIPLET}-g++
export AR=${TARGET_TRIPLET}-ar
export STRIP=${TARGET_TRIPLET}-strip

echo "Cross-compilation setup:"
echo "  Target: $TARGET_TRIPLET"
echo "  Sysroot: $SYSROOT_PATH"
echo "  CC: $CC"
echo "  CXX: $CXX"

# Create build directory
echo "Creating build directory: $BUILD_DIR"
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

# Create toolchain file
TOOLCHAIN_FILE="rpi-toolchain.cmake"
cat > "$TOOLCHAIN_FILE" << EOF
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR $TARGET_ARCH)

set(CMAKE_SYSROOT $SYSROOT_PATH)
set(CMAKE_STAGING_PREFIX \${CMAKE_SYSROOT})

set(CMAKE_C_COMPILER $CC)
set(CMAKE_CXX_COMPILER $CXX)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Qt6 specific paths (adjust as needed for your sysroot)
set(Qt6_DIR \${CMAKE_SYSROOT}/usr/lib/aarch64-linux-gnu/cmake/Qt6)
set(Qt6Core_DIR \${CMAKE_SYSROOT}/usr/lib/aarch64-linux-gnu/cmake/Qt6Core)
set(Qt6Quick_DIR \${CMAKE_SYSROOT}/usr/lib/aarch64-linux-gnu/cmake/Qt6Quick)
set(Qt6SerialBus_DIR \${CMAKE_SYSROOT}/usr/lib/aarch64-linux-gnu/cmake/Qt6SerialBus)
set(Qt6SerialPort_DIR \${CMAKE_SYSROOT}/usr/lib/aarch64-linux-gnu/cmake/Qt6SerialPort)
EOF

# Configure with CMake
echo "Configuring with CMake..."
cmake .. \
    -DCMAKE_TOOLCHAIN_FILE="$TOOLCHAIN_FILE" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local

# Build
echo "Cross-compiling application..."
make -j$(nproc) || make -j1

# Check if binary was created
if [ -f "appvolan" ]; then
    echo "Cross-compilation successful!"
    echo "Binary location: $(pwd)/appvolan"
    echo "Binary size: $(ls -lh appvolan | awk '{print $5}')"
    echo "Target architecture: $(file appvolan | cut -d: -f2-)"
    
    echo ""
    echo "To deploy to Raspberry Pi:"
    echo "  scp appvolan pi@your-rpi-ip:~/"
    echo ""
    echo "Then on Raspberry Pi:"
    echo "  1. Set up CAN interface: sudo ip link set can0 up type can bitrate 1000000"
    echo "  2. Run: ./appvolan"
    
else
    echo "Cross-compilation failed - binary not found"
    exit 1
fi