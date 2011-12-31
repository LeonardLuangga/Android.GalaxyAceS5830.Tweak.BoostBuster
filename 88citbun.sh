#!/system/bih/sh
#
# Copyright © 2011 Leonard Luangga


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
echo "NO_GENTLE_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features;
echo "NO_NEW_FAIR_SLEEPERS" > /sys/kernel/debug/sched_features;
echo "NO_NORMALIZED_SLEEPER" > /sys/kernel/debug/sched_features;


#battery tweaks (vm)
echo 0 > /proc/sys/vm/laptop_mode;
echo 1000 > /proc/sys/vm/dirty_expire_centisecs;
echo 2000 > /proc/sys/vm/dirty_writeback_centisecs;
echo 50 > /proc/sys/vm/dirty_ratio;
echo 20 > /proc/sys/vm/dirty_background_ratio;


#vm management tweaks
echo 0 > /proc/sys/vm/panic_on_oom;
echo 0 > /proc/sys/vm/overcommit_memory;
echo 0 > /proc/sys/vm/oom_kill_allocating_task;
echo 3 > /proc/sys/vm/page-cluster;
echo 10 > /proc/sys/vm/swappiness;
echo 50 > /proc/sys/vm/vfs_cache_pressure;
echo 4096 > /proc/sys/vm/min_free_kbytes;

#value for /proc/sys/vm/min_free_kbytes
# RAM          min_free_kbytes
# 16MB:        1024k
# 32MB:        1448k
# 64MB:        2048k
# 128MB:       2896k
# 256MB:       4096k
# 512MB:       5792k
# 1024MB:      8192k
# 2048MB:      11584k
# 4096MB:      16384k


#kernel tweaks
echo 1 > /proc/sys/kernel/panic_on_oops;
echo 60 > /proc/sys/kernel/panic;
echo 30 > /proc/sys/fs/lease-break-time;
echo 64000 > /proc/sys/kernel/msgmni; #1024
echo 64000 > /proc/sys/kernel/msgmax;
echo 1000000 > /proc/sys/kernel/sched_rt_period_us;
echo 950000 > /proc/sys/kernel/sched_rt_runtime_us;
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


#governor tweaks
#SAMPLING_RATE=$(busybox expr `cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_transition_latency` \* 750 / 1000);
#echo $SAMPLING_RATE > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate;
echo 70 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold;
echo 10000 > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate;


#optimize build.prop
#setprop ro.ril.hsxpa 2; #HSDPA/UMTS? I think this one gonna drain more and more battery
#setprop ro.ril.hsxpa 1; #HSDPA only? hmm I think this one drain more battery than UMTS only
setprop ro.ril.hsxpa 0; #UMTS only, slower but I think this one drain less battery
setprop ro.ril.gprsclass 10;
setprop ro.ril.hep 1;
setprop ro.ril.enable.dtm 0;
setprop ro.ril.hsupa.category 6;
setprop ro.ril.hsdpa.category 8;
setprop ro.ril.enable.a53 1;
setprop ro.ril.enable.3g.prefix 1;
setprop net.tcp.buffersize.default 4096,87380,256960,4096,16384,256960;
setprop net.tcp.buffersize.wifi 4096,87380,256960,4096,16384,256960;
setprop net.tcp.buffersize.umts 4096,87380,256960,4096,16384,256960;
setprop net.tcp.buffersize.edge 4096,87380,256960,4096,16384,256960;
setprop net.tcp.buffersize.gprs 4096,87380,256960,4096,16384,256960;
setprop wifi.supplicant_scan_interval 600;
setprop windowsmgr.max_events_per_sec 60;
setprop windowsmgr.support_rotation_270 true;
setprop ro.mot.eri.losalert.delay 1000;
setprop ro.lge.proximity.delay 25;
setprop mot.proximity.delay 75;
setprop persist.sys.use_dithering 0;
setprop persist.sys.purgeable_assets 1;
setprop ro.HOME_APP_ADJ 1;
setprop ro.HOME_APP_MEM 2048;
setprop video.accelerate.hw 1;
setprop media.stagefright.enable-player true;
setprop ro.ril.disable.power.collapse 0;
setprop persist.adb.notify 0;
setprop pm.sleep_mode 1;
setprop debug.sf.hw 1;
setprop debug.performance.tuning 1;
