#!/bin/bash

TOOLS_PATH=$(realpath $(pwd)/../tools)

if [ -d "$TOOLS_PATH" ]
then
   PATH="$TOOLS_PATH/gcc-linaro-arm-none-eabi-4.8-2014.04_linux/bin:$PATH"
   PATH="$TOOLS_PATH/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PATH"
else
   echo "Tools not found in $TOOLS_PATH"
fi
export CROSS_COMPILE="$TOOLS_PATH/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin/aarch64-none-elf-"
make distclean
make gxl_p212_v1_config
make
if [ $? == 0 ]
then
    echo -e "U-Boot for Vero 3 built successfully"
    echo -e "You can install this to an SD card with"
    echo -e "dd if=build/u-boot.bin of=/dev/mmcblk0 conv=fdatasync,notrunc bs=1 count=112"
    echo -e "dd if=build/u-boot.bin of=/dev/mmcblk0 conv=fdatasync,notrunc bs=512 skip=1 seek=1"
fi
