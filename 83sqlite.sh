#!/system/bin/sh
# Copyright© 2011 pikachu01


# Optimize Sqlite databases from apps
for i in \
`busybox find /data -iname "*.db"`; 
do \
  /system/xbin/sqlite3 $i 'VACUUM;'; 
	/system/xbin/sqlite3 $i 'REINDEX;'; 
done;

if [ -d "/dbdata" ]; then
	for i in \
	`busybox find /dbdata -iname "*.db"`; 
	do \
		/system/xbin/sqlite3 $i 'VACUUM;'; 
		/system/xbin/sqlite3 $i 'REINDEX;'; 
	done;
fi;


if [ -d "/datadata" ]; then
	for i in \
	`busybox find /datadata -iname "*.db"`; 
	do \
		/system/xbin/sqlite3 $i 'VACUUM;'; 
		/system/xbin/sqlite3 $i 'REINDEX;'; 
	done;
fi;


for i in \
`busybox find /sdcard -iname "*.db"`; 
do \
	/system/xbin/sqlite3 $i 'VACUUM;'; 
	/system/xbin/sqlite3 $i 'REINDEX;'; 
done;

