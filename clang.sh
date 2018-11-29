#!/bin/bash
#

#Custom Build Script

#
# Copyright © 3.00, "DarkAbhi" <basevd94@gmail.com>
#
# This software is licensed under the terms of the GNU General Public
# License version 2, as published by the Free Software Foundation, and
# may be copied, distributed, and modified under those terms.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# Please maintain this if you use this script or any part of it
#

# Init Script
KERNEL_DIR=$PWD
KERNEL="Image.gz-dtb"
KERN_IMG=$KERNEL_DIR/out/arch/arm64/boot/Image.gz-dtb
BUILD_START=$(date +"%s")
BASE_VER="RawWork"
KERNEL_VER=1.0
ANYKERNEL_DIR=/home/darkabhi/AnyKernel2/asus
EXPORT_DIR=/home/darkabhi/flashablezips/asus/
file=$PWD/clang.sh
FINAL_ZIP=$BASE_VER-v$KERNEL_VER.zip

# Release
VER="$KERNEL_VER-$(date +"%Y-%m-%d"-%H%M)-"


# Color Code Script
black='\e[0;30m'        # Black
red='\e[0;31m'          # Red
green='\e[0;32m'        # Green
yellow='\e[0;33m'       # Yellow
blue='\e[0;34m'         # Blue
purple='\e[0;35m'       # Purple
cyan='\e[0;36m'         # Cyan
white='\e[0;37m'        # White
nocol='\033[0m'         # Default

# Tweakable Stuff
export ARCH=arm64
export SUBARCH=arm
export KBUILD_BUILD_USER="DarkAbhi"
export KBUILD_BUILD_HOST="Arch"
export CROSS_COMPILE=/home/darkabhi/toolchains/aarch64--glibc--bleeding-edge-2018.07-3-gcc8.2.1/bin/aarch64-linux-
export KBUILD_COMPILER_STRING=$(/home/darkabhi/toolchains/RawWork-clang/bin/clang --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//')

#COMPILATION SCRIPTS
echo -e "${green}"
echo "--------------------------------------------------------"
echo "      Initializing build to compile Ver: $VER    "
echo "--------------------------------------------------------"

echo -e "$cyan***********************************************"
echo "         Creating Output Directory: out      "
echo -e "***********************************************$nocol"

mkdir -p out

echo -e "$green***********************************************"
echo "          Putting in effort into raw materials !!      "
echo -e "***********************************************$nocol"

make O=out clean
make O=out mrproper

echo -e "$cyan***********************************************"
echo "          Initialising DEFCONFIG        "
echo -e "***********************************************$nocol"

make O=out ARCH=arm64 rawwork_defconfig 

echo -e "$cyan***********************************************"
echo "          Providing The Raw Work!!        "
echo -e "***********************************************$nocol"

make -j$(nproc --all) O=out ARCH=arm64 \
			CC="/home/darkabhi/toolchains/RawWork-clang/bin/clang" \
			CLANG_TRIPLE="aarch64-linux-gnu-"


if ! [ -a $KERN_IMG ];
then
echo -e "$Red Kernel Compilation failed! Fix the errors! $nocol"
exit 1
fi

# BUILD TIME
BUILD_END=$(date +"%s")
DIFF=$(($BUILD_END - $BUILD_START))
echo -e "$cyan Build completed in $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds.$nocol"
# END
