#!/bin/bash

source ./set_env.sh
RAMDISK=./twrp
./ramdisk_permit_fix.sh

./utility/mkbootfs $RAMDISK | lzop -9 > ./utility/twrp.img
cp -f ./arch/arm/boot/zImage ./utility/n910-zImage

DTB=n910k-boot.img-dtb

./utility/mkbootimg --base 0x10000000 --pagesize 2048 --board SYSMAGIC000K --kernel ./utility/n910-zImage --ramdisk ./utility/twrp.img --dt ./utility/$DTB -o ./utility/n910-recovery.img
echo -n "SEANDROIDENFORCE" >> ./utility/n910-recovery.img
cp -f  ./utility/n910-recovery.img ../HostPC/Kernel/recovery.img

echo ""
echo - wating device...
adb wait-for-device
echo - push n910-recovery.img to /device/sdcard/ ...
adb shell "rm -f /data/local/tmp/recovery.img"
adb push ./utility/n910-recovery.img /data/local/tmp/recovery.img
echo - flashing image...
adb shell "su -c dd if=/data/local/tmp/recovery.img of=/dev/block/platform/15540000.dwmmc0/by-name/RECOVERY"
adb shell "rm -f /data/local/tmp/recovery.img"
echo - flashing done. device reboot!
adb reboot
echo ""

