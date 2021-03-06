#!/system/bih/sh
#
# Copyright (c) 2011 Leonard Luangga


#drop caches to free some memory
sync;
echo 3 > /proc/sys/vm/drop_caches; #free pagecache, dentries and inodes
sleep 1;
echo 1 > /proc/sys/vm/drop_caches; #free pagecache. dentries and inodes will be managed by /proc/sys/vm/vfs_cache_pressure


#internet speed tweaks
echo 0 > /proc/sys/net/ipv4/tcp_timestamps;
echo 0 > /proc/sys/net/ipv4/tcp_tw_recycle;
echo 1 > /proc/sys/net/ipv4/tcp_tw_reuse;
echo 1 > /proc/sys/net/ipv4/tcp_sack;
echo 1 > /proc/sys/net/ipv4/tcp_window_scaling;
echo 5 > /proc/sys/net/ipv4/tcp_keepalive_probes;
echo 20 > /proc/sys/net/ipv4/tcp_keepalive_intvl;
echo 1800 > /proc/sys/net/ipv4/tcp_keepalive_time;
echo 30 > /proc/sys/net/ipv4/tcp_fin_timeout;
echo 404480 > /proc/sys/net/core/wmem_max;
echo 404480 > /proc/sys/net/core/rmem_max;
echo 256960 > /proc/sys/net/core/rmem_default;
echo 256960 > /proc/sys/net/core/wmem_default;
echo 4096 16384 404480 > /proc/sys/net/ipv4/tcp_wmem;
echo 4096 87380 404480 > /proc/sys/net/ipv4/tcp_rmem;


#battery tweaks (sleepers)
mount -t debugfs none /sys/kernel/debug
echo NO_NEW_FAIR_SLEEPERS > /sys/kernel/debug/sched_features;
echo NO_NORMALIZED_SLEEPERS > /sys/kernel/debug/sched_features;
umount /sys/kernel/debug


#battery tweaks (vm)
echo 0 > /proc/sys/vm/laptop_mode;
echo 500 > /proc/sys/vm/dirty_expire_centisecs;
echo 1000 > /proc/sys/vm/dirty_writeback_centisecs;
echo 60 > /proc/sys/vm/dirty_ratio;
echo 45 > /proc/sys/vm/dirty_background_ratio;


#vm management tweaks
echo 0 > /proc/sys/vm/panic_on_oom;
echo 0 > /proc/sys/vm/overcommit_memory;
echo 0 > /proc/sys/vm/oom_kill_allocating_task;
echo 3 > /proc/sys/vm/page-cluster;
echo 10 > /proc/sys/vm/swappiness;
echo 50 > /proc/sys/vm/vfs_cache_pressure; #default value=100. low value can cause memory leak, high value drains more battery
echo 2896 > /proc/sys/vm/min_free_kbytes;

#default value for /proc/sys/vm/min_free_kbytes
# RAM		min_free_kbytes
# 16MB		512k
# 32MB		724k
# 64MB		1024k
# 128MB		1448k
# 256MB		2048k
# 512MB		2896k
# 1024MB	4096k
# 2048MB	5792k
# 4096MB	8192k
# 8192MB	11584k


#kernel tweaks
#echo 1 > /proc/sys/kernel/panic_on_oops;
#echo 60 > /proc/sys/kernel/panic;
echo 0 > /proc/sys/kernel/panic_on_oops;
echo 30 > /proc/sys/fs/lease-break-time;
#echo 64000 > /proc/sys/kernel/msgmni; #1024
#echo 64000 > /proc/sys/kernel/msgmax;
#echo 1000000 > /proc/sys/kernel/sched_rt_period_us;
#echo 950000 > /proc/sys/kernel/sched_rt_runtime_us;
echo 500 512000 64 2048 > /proc/sys/kernel/sem;

if [ -e /proc/sys/kernel/sched_min_granularity_ns ]
then
	echo 200000 > /proc/sys/kernel/sched_min_granularity_ns;
fi

if [ -e /proc/sys/kernel/sched_latency_ns ]
then
	echo 400000 > /proc/sys/kernel/sched_latency_ns;
fi

if [ -e /proc/sys/kernel/sched_wakeup_granularity_ns ]
then
	echo 100000 > /proc/sys/kernel/sched_wakeup_granularity_ns;
fi

if [ -e /proc/sys/kernel/hung_task_timeout_secs ]
then
	echo 45 > /proc/sys/kernel/hung_task_timeout_secs;
fi


#lowmemorykiller tweaks
if [ -e /sys/module/lowmemorykiller/parameters/adj ]
then
	echo "0,1,2,4,6,15" > /sys/module/lowmemorykiller/parameters/adj;
fi

if [ -e /sys/module/lowmemorykiller/parameters/minfree ]
then
	echo "2560,4096,6144,12288,14336,18432" > /sys/module/lowmemorykiller/parameters/minfree;
fi


#governor tweaks
#SAMPLING_RATE=$(busybox expr `cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency` \* 750 / 1000);
#echo $SAMPLING_RATE > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate;
#echo 10000 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate;
echo 70 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold;


#optimize build.prop
#setprop ro.ril.hsxpa 2; #HSDPA/UMTS? I think this one gonna drain more and more battery
#setprop ro.ril.hsxpa 1; #HSDPA only? hmm I think this one drain more battery than UMTS only
setprop ro.ril.hsxpa 0; #UMTS only? slower but I think this one drain less battery
setprop ro.ril.gprsclass 10;
setprop ro.ril.hsupa.category 6;
setprop ro.ril.hsdpa.category 8;
setprop ro.ril.hep 1;
setprop ro.ril.enable.dtm 1;
setprop ro.ril.enable.a53 1;
setprop ro.ril.enable.3g.prefix 1;
setprop keyguard.no_require_sim true;
setprop net.tcp.buffersize.default 4096,87380,256960,4096,16384,256960;
setprop net.tcp.buffersize.wifi 4096,87380,256960,4096,16384,256960;
setprop net.tcp.buffersize.umts 4096,87380,256960,4096,16384,256960;
setprop net.tcp.buffersize.edge 4096,87380,256960,4096,16384,256960;
setprop net.tcp.buffersize.gprs 4096,87380,256960,4096,16384,256960;
setprop wifi.supplicant_scan_interval 300;
setprop windowsmgr.max_events_per_sec 150;
setprop windowsmgr.support_rotation_270 true;
setprop ro.mot.eri.losalert.delay 1000;
setprop ro.lge.proximity.delay 25;
setprop mot.proximity.delay 25;
setprop persist.sys.use_dithering 0;
setprop persist.sys.purgeable_assets 1;
setprop ro.media.dec.jpeg.memcap 20000000;
setprop ro.media.enc.jpeg.quality 100;
setprop ro.HOME_APP_ADJ 1;
setprop ro.HOME_APP_MEM 2048;
setprop dalvik.vm.heapsize 48m;
setprop video.accelerate.hw 1;
setprop media.stagefright.enable-player true;
setprop ro.ril.disable.power.collapse 0;
setprop persist.adb.notify 0;
setprop pm.sleep_mode 1;
setprop debug.sf.hw 1;
setprop debug.performance.tuning 1;
setprop dalvik.vm.execution-mode int:jit
#untested
#setprop ro.kernel.android.checkjni 0; #does it really fix some apps issue? http://forum.xda-developers.com/archive/index.php/t-1253326.html
#setprop ro.mot.buttonlight.timeout 0; #force button lights on when screen is on

