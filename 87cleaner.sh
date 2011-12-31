#!/system/bin/sh
#
# Copyright © 2011 Leonard Luangga


#remove cache, tmp, and unused files
rm -f /cache/*.apk
rm -f /cache/*.tmp
rm -f /data/dalvik-cache/*.apk
rm -f /data/dalvik-cache/*.tmp

if [ -e /data/system/userbehavior.db ]
then
  rm -f /data/system/userbehavior.db
fi

if [ -d /data/system/usagestats ]
then
  chmod 400 /data/system/usagestats
fi

if [ -d /data/system/appusagestats ]
then
  chmod 400 /data/system/appusagestats
fi


#remove main log
if [ -e /dev/log/main ]
then
  rm -f /dev/log/main
fi
