#!/system/bin/sh
#
# Copyright (c) 2011 Leonard Luangga


#ping/icmp protection
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts;
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all;
echo 1 > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses;

if [ -e /proc/sys/net/ipv6/icmp_echo_ignore_broadcasts ]
then
  echo 1 >  /proc/sys/net/ipv6/icmp_echo_ignore_broadcasts;
fi

if [ -e /proc/sys/net/ipv6/icmp_echo_ignore_all ]
then
	echo 1 >  /proc/sys/net/ipv6/icmp_echo_ignore_all;
fi

if [ -e /proc/sys/net/ipv6/icmp_ignore_bogus_error_responses ]
then
	echo 1 >  /proc/sys/net/ipv6/icmp_ignore_bogus_error_responses;
fi


#syn protection
echo 2 > /proc/sys/net/ipv4/tcp_synack_retries;

if [ -e /proc/sys/net/ipv6/tcp_synack_retries ]
then
	echo 2 > /proc/sys/net/ipv6/tcp_synack_retries;
fi

if [ -e /proc/sys/net/ipv6/tcp_syncookies ]
then
	echo 0 >  /proc/sys/net/ipv6/tcp_syncookies;
fi

if [ -e /proc/sys/net/ipv4/tcp_syncookies ]
then
	echo 1 >  /proc/sys/net/ipv4/tcp_syncookies;
fi


#drop spoof, redirects, etc
echo 1 > /proc/sys/net/ipv4/conf/all/rp_filter;
echo 1 > /proc/sys/net/ipv4/conf/default/rp_filter;
echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects;
echo 0 > /proc/sys/net/ipv4/conf/default/send_redirects;
echo 0 > /proc/sys/net/ipv4/conf/default/accept_redirects;
echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route;
echo 0 > /proc/sys/net/ipv4/conf/default/accept_source_route;

if [ -e /proc/sys/net/ipv6/conf/all/rp_filter ]
then
	echo 1 > /proc/sys/net/ipv6/conf/all/rp_filter;
fi

if [ -e /proc/sys/net/ipv6/conf/default/rp_filter ]
then
	echo 1 > /proc/sys/net/ipv6/conf/default/rp_filter;
fi

if [ -e /proc/sys/net/ipv6/conf/all/send_redirects ]
then
	echo 0 > /proc/sys/net/ipv6/conf/all/send_redirects;
fi

if [ -e /proc/sys/net/ipv6/conf/default/send_redirects ]
then
	echo 0 > /proc/sys/net/ipv6/conf/default/send_redirects;
fi

if [ -e /proc/sys/net/ipv6/conf/default/accept_redirects ]
then
	echo 0 > /proc/sys/net/ipv6/conf/default/accept_redirects;
fi

if [ -e /proc/sys/net/ipv6/conf/all/accept_source_route ]
then
	echo 0 > /proc/sys/net/ipv6/conf/all/accept_source_route;
fi

if [ -e /proc/sys/net/ipv6/conf/default/accept_source_route ]
then
	echo 0 > /proc/sys/net/ipv6/conf/default/accept_source_route;
fi

