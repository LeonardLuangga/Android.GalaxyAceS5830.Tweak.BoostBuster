#!/system/bin/sh
# Automatic ZipAlign by Wes Garner
# ZipAlign files in /data that have not been previously ZipAligned (using md5sum)
# Thanks to oknowton for the changes
# Credits to GadgetCheck system/app and /system/framework (Ace)

LOG_FILE=/data/zipalign.log

if [ -n $zipalign ] && [ $zipalign = "true" ]
then
  busybox mount -o remount,rw /;
	busybox mount -o remount,rw -t auto /system;
	busybox mount -o remount,rw -t auto /data;
fi

busybox mount -t tmpfs -o size=70m none /mnt/tmp;
echo "Starting Hyperdroid Automatic ZipAlign " `date` | tee -a $LOG_FILE;

if [ -e $LOG_FILE ]
then
	rm $LOG_FILE;
fi
    	
echo "Starting Automatic ZipAlign $( date +"%m-%d-%Y %H:%M:%S" )" | tee -a $LOG_FILE;
for apk in /data/app/*.apk
do
	zipalign -c 4 $apk;
	ZIPCHECK=$?;
	if [ $ZIPCHECK -eq 1 ]
	then
		echo ZipAligning $(basename $apk)  | tee -a $LOG_FILE;
		zipalign -f 4 $apk /cache/$(basename $apk);
		if [ -e /cache/$(basename $apk) ]
		then
			cp -f -p /cache/$(basename $apk) $apk  | tee -a $LOG_FILE;
			rm /cache/$(basename $apk);
		else
			echo ZipAligning $(basename $apk) Failed  | tee -a $LOG_FILE;
		fi
	else
		echo ZipAlign already completed on $apk  | tee -a $LOG_FILE;
	fi
done


for apk in /system/app/*.apk
do
	zipalign -c 4 $apk;
	ZIPCHECK=$?;
	if [ $ZIPCHECK -eq 1 ]
	then
		echo ZipAligning $(basename $apk)  | tee -a $LOG_FILE;
		zipalign -f 4 $apk /cache/$(basename $apk);
		if [ -e /cache/$(basename $apk) ]
		then
			cp -f -p /cache/$(basename $apk) $apk  | tee -a $LOG_FILE;
			rm /cache/$(basename $apk);
		else
			echo ZipAligning $(basename $apk) Failed  | tee -a $LOG_FILE;
		fi
	else
		echo ZipAlign already completed on $apk  | tee -a $LOG_FILE;
	fi
done


for apk in /system/framework/*.apk
do
	zipalign -c 4 $apk;
	ZIPCHECK=$?;
	if [ $ZIPCHECK -eq 1 ]
	then
		echo ZipAligning $(basename $apk)  | tee -a $LOG_FILE;
		zipalign -f 4 $apk /cache/$(basename $apk);
		if [ -e /cache/$(basename $apk) ]
		then
			cp -f -p /cache/$(basename $apk) $apk  | tee -a $LOG_FILE;
			rm /cache/$(basename $apk);
		else
			echo ZipAligning $(basename $apk) Failed  | tee -a $LOG_FILE;
		fi
	else
		echo ZipAlign already completed on $apk  | tee -a $LOG_FILE;
	fi
done

echo "Automatic ZipAlign finished at $( date +"%m-%d-%Y %H:%M:%S" )" | tee -a $LOG_FILE;

