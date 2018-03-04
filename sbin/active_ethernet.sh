#!/bin/sh
#
# For eth2.2 Enable client
#
# usage: enable_dhcpc.sh
#

#PID=`cat /var/run/udhcpc2.pid`

#kill -9 $PID

#udhcpc -i eth2.1 -s /sbin/udhcpc.sh -p /var/run/udhcpc2.pid &
OPMODE=`nvram_get OperationMode`
if [ "$OPMODE" = "1" ]; then
	echo "AP mode , Enable Ethernet"
	udhcpc -i eth2.2 -s /sbin/udhcpc.sh -p /var/run/udhcpc.pid &
else
	echo "STA mode , Enable Ethernet"
	ifconfig ra0 0.0.0.0
	udhcpc -i eth2.1 -s /sbin/udhcpc.sh -p /var/run/udhcpc2.pid &
fi
