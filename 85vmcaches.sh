#!/system/bin/sh
#
# Copyright © 2011 Leonard Luangga


sync;
sleep 1;

echo 3 > /proc/sys/vm/drop_caches;
