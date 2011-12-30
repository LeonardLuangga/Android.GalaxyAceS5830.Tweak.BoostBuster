#!/system/bin/sh


LOOP=`ls -d /sys/block/loop*`;
RAM=`ls -d /sys/block/ram*`;
MTD=`ls -d /sys/block/mtd*`;
MMC=`ls -d /sys/block/mmc*`;
STL=`ls -d /sys/block/stl*`;
BML=`ls -d /sys/block/bml*`;
ZRM=`ls -d /sys/block/zram*`;


#optimize memory
for i in $LOOP $RAM $MTD $MMC $STL $BML $ZRM
do
  if [ -e $i/queue/scheduler ]
	then
		echo cfq > $i/queue/scheduler;
	fi
	
	if [ -e $i/queue/rotational ]
	then
		echo 0 > $i/queue/rotational;
	fi
	
	if [ -e $i/queue/iosched/quantum ]
	then
		echo 4 > $i/queue/iosched/quantum;
	fi
	
	if [ -e $i/queue/iosched/slice_async_rq ]
	then
		echo 2 > $i/queue/iosched/slice_async_rq;
	fi
	
	if [ -e $i/queue/iosched/slice_idle ]
	then
		echo 0 > $i/queue/iosched/slice_idle;
	fi
	
	if [ -e $i/queue/iosched/low_latency ]
	then
		echo 1 > $i/queue/iosched/low_latency;
	fi
	
	if [ -e $i/queue/iosched/group_isolation ]
	then
		echo 0 > $i/queue/iosched/group_isolation;
	fi
done


for j in $MTD $MMC $STL $BML $ZRM
do
	if [ -e $j/queue/nr_requests ]
	then
		echo 512 > $j/queue/nr_requests;
	fi
	
	if [ -e $i/queue/read_ahead_kb ]
	then
		echo 1024 > $i/queue/read_ahead_kb;
	fi
	
	if [ -e $j/queue/iostats ]
	then
		echo 0 > $j/queue/iostats;
	fi
	
	if [ -e $j/queue/iosched/back_seek_penalty ]
	then
		echo 1 > $j/queue/iosched/back_seek_penalty;
	fi
	
	if [ -e $j/queue/iosched/back_seek_max ]
	then
		echo 1000000000 > $j/queue/iosched/back_seek_max;
	fi
done


if [ -e /sys/devices/virtual/bdi/179:0/read_ahead_kb ]
then
    /system/xbin/echo "2048" > /sys/devices/virtual/bdi/179:0/read_ahead_kb;
fi

if [ -e /sys/devices/virtual/bdi/179:8/read_ahead_kb ]
then
    /system/xbin/echo "2048" > /sys/devices/virtual/bdi/179:8/read_ahead_kb;
fi

if [ -e /sys/devices/virtual/bdi/default/read_ahead_kb ]
then
    /system/xbin/echo "1024" > /sys/devices/virtual/bdi/default/read_ahead_kb;
fi


#remount all partitions with noatime and nodiratime
for k in $(busybox mount | grep relatime | cut -d " " -f3);
do
	sync
	busybox mount -o remount,noatime,nodiratime $k
done

for l in $(busybox mount | grep ext4 | cut -d " " -f3)
do
	sync
	busybox mount -o remount,commit=15 $l
done
