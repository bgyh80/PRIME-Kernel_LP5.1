#!/bin/bash

#!/bin/bash

TWRP=../ramdisk-twrp
CDATE=$(date +"%Y%m%d")

	./utility/mkbootfs $TWRP | lzop -9 > ./utility/TWRP.img

	echo "- n916-SKT"
	DTB=n916s-boot.img-dtb
	mtp_nosec
	./utility/mkbootimg --base 0x10000000 --pagesize 2048 --board SYSMAGIC001K --kernel ./utility/n916-zImage --ramdisk ./utility/TWRP.img --dt ./utility/$DTB -o ./utility/recovery.img
	echo -n "SEANDROIDENFORCE" >> ./utility/recovery.img
	cd utility && tar -cvf twrp-2.8.7.0-$CDATE-N916.tar recovery.img >/dev/null 2>&1 && cd ..
	cp -f ./utility/recovery.img ../HostPC/Kernel/n916-recovery.img
	mv -f ./utility/twrp-2.8.7.0-$CDATE-N916.tar ../HostPC/Kernel/
	mv ./utility/recovery.img ./utility/n916-recovery.img

	echo "- N915-SKT"
	DTB=n915s-boot.img-dtb
	mtp_nosec
	./utility/mkbootimg --base 0x10000000 --pagesize 2048 --board SYSMAGIC000K --kernel ./utility/n915-zImage --ramdisk ./utility/TWRP.img --dt ./utility/$DTB -o ./utility/recovery.img
	echo -n "SEANDROIDENFORCE" >> ./utility/recovery.img
	cd utility && tar -cvf twrp-2.8.7.0-$CDATE-N915.tar recovery.img >/dev/null 2>&1 && cd ..
	cp -f  ./utility/recovery.img ../HostPC/Kernel/n915-recovery.img
	mv -f ./utility/twrp-2.8.7.0-$CDATE-N915.tar ../HostPC/Kernel/
	mv ./utility/recovery.img ./utility/n915-recovery.img

	echo "- N910-SKT"
	DTB=n910k-boot.img-dtb
	mtp_nosec
	./utility/mkbootimg --base 0x10000000 --pagesize 2048 --board SYSMAGIC000K --kernel ./utility/n910-zImage --ramdisk ./utility/TWRP.img --dt ./utility/$DTB -o ./utility/recovery.img
	echo -n "SEANDROIDENFORCE" >> ./utility/recovery.img
	cd utility && tar -cvf twrp-2.8.7.0-$CDATE-N910.tar recovery.img >/dev/null 2>&1 && cd ..
	cp -f  ./utility/recovery.img ../HostPC/Kernel/recovery.img
	cp -f  ./utility/recovery.img ../HostPC/Kernel/n910-recovery.img
	mv -f ./utility/twrp-2.8.7.0-$CDATE-N910.tar ../HostPC/Kernel/
	mv ./utility/recovery.img ./utility/n910-recovery.img

echo ""
echo "- Compression"
echo ""

cd utility
rm recovery.tar.xz 2>/dev/null
tar -cvf recovery.tar n91*-recovery.img
xz -z -9 recovery.tar
cp -f recovery.tar.xz ../../HostPC/Kernel/
cd ..

echo ""
echo "- DONE!!"
echo ""

