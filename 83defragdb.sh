#!/system/bin/sh

for i in \
`find /data -iname "*.db"`
do \
sqlite3 $i 'VACUUM;'; 
done
