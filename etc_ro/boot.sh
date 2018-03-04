#!/bin/sh
sleep 10
echo "HwAntDiv"
iwpriv ra0 set HwAntDiv=2
sleep 8
#port=`nvram_get Port`
#echo "connection_start"

echo 45 > /proc/sys/net/ipv4/tcp_keepalive_time
echo 5 > /proc/sys/net/ipv4/tcp_keepalive_intvl
echo 3 > /proc/sys/net/ipv4/tcp_keepalive_probes







