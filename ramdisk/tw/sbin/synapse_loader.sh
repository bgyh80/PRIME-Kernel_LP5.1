#!/res/bin/busybox sh

SYNAPSE_LOADER_SRC=/data/StockRider/bin/synapse_loader212
SYNAPSE_LOADER_EXE=/data/local/tmp/synapse_loader.shx
SYNAPSE_LOADER_ACT=1
SYNAPSE_LOADER_LOG=/sdcard/synapse_loader.log
LOADER_VER_PATH=/data/StockRider/synapse_loader_ver

rm $SYNAPSE_LOADER_LOG
rm $LOADER_VER_PATH

# Addon install
ADDON_LIST=$( ls /data/media/0/Synapse/StockRider-DonateAddon_*|/res/bin/busybox sort )
if [ ! -e $SYNAPSE_LOADER_SRC ] && [ ! -z $ADDON_LIST ]; then
	ADDON_COUNT=`/res/bin/busybox expr ${#ADDON_LIST[@]} - 1`
	[[ -z $ADDON_COUNT ]] && ADDON_COUNT=0
	ADDON_FILE=${ADDON_LIST[$ADDON_COUNT]}
	TMP_DIR=/data/local/tmp/stockrider
	
	mkdir $TMP_DIR
	
	$BB unzip -o $ADDON_FILE -d $TMP_DIR
	cp -rf $TMP_DIR/data/. /data/StockRider/
	$BB chmod -R 0755 /data/StockRider/.
	rm -rf $TMP_DIR
fi

echo synapseloader start >> /data/StockRider/kernel.log
echo - excecuted on $(date +"%Y-%d-%m %r") >> /data/StockRider/kernel.log

if [ -f $SYNAPSE_LOADER_SRC ] && [ -f /system/xbin/su ]; then
    echo - synapse_loader start: pase 0 - su detected >> $SYNAPSE_LOADER_LOG
    UNROOT_ONLY=`cat /data/StockRider/synapse/settings/loader_unroot`
    if [ "$UNROOT_ONLY" == "1" ]; then
        echo - synapse_loader: disabled, using unroot only option >> $SYNAPSE_LOADER_LOG
        SYNAPSE_LOADER_ACT=0
    fi
fi
if [ -f $SYNAPSE_LOADER_SRC ]; then
	echo - synapse_loader: pase 1 >> $SYNAPSE_LOADER_LOG
	cat $SYNAPSE_LOADER_SRC|/res/bin/busybox base64 -d > $SYNAPSE_LOADER_EXE
	chmod 755 $SYNAPSE_LOADER_EXE
	LOADER_VER=`echo $($SYNAPSE_LOADER_EXE version)`
	if [[ "$LOADER_VER" < "2.0" ]]; then
		SYNAPSE_LOADER_SRC="synapseloader_notfound"
		echo 0 >> $LOADER_VER_PATH
	else
		echo $LOADER_VER > $LOADER_VER_PATH
	fi
fi
if [ -f $SYNAPSE_LOADER_SRC ] && [ $SYNAPSE_LOADER_ACT -eq 1 ]; then
	$BB sh $SYNAPSE_LOADER_EXE
	echo - synapse_loader: pase 2 : done >> $SYNAPSE_LOADER_LOG
fi

sleep 20
rm -f $SYNAPSE_LOADER_EXE

