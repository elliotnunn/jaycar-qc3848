#!/bin/sh
#
# For eth2.1 Enable client
#
# usage: enable_dhcpc.sh
#

PID=`cat /var/run/udhcpc2.pid`

kill -9 $PID

udhcpc -i eth2.1 -s /sbin/udhcpc.sh -p /var/run/udhcpc2.pid &
