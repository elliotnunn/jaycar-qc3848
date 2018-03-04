#!/bin/sh

apcli0=`ifconfig apcli0 | grep inet | awk '{print $2}' | sed -e 's/.*addr://g'`

if [ "$apcli0" != "" ]; then
	echo "apcli"
	ifconfig apcli0 0.0.0.0
	udhcpc -i eth2 -s /sbin/udhcpc.sh &
else
	echo "not apcli"
	udhcpc -i eth2 -s /sbin/udhcpc.sh &
fi
