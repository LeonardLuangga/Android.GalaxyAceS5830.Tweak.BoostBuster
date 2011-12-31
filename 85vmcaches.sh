#!/system/bin/sh
# Copyright© 2011 redmaner

sync;

sleep 1;
echo "3" > /proc/sys/vm/drop_caches;

sleep 1;
echo "1" > /proc/sys/vm/drop_caches;
