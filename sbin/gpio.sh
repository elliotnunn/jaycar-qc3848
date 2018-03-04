#!/bin/sh
#
# for restore default setting
#
# First 2012,11,28 Dingdong
#
# usage : gpio.sh
#
count=0
default=0x0

while [ "1" ]; do
	gpio=`gpio r | grep 14 | awk '{print $4}'`
	if [ "$gpio" = "$default" ]; then
		count=`expr $count + 1`
		echo "$count sec"
		if [ "$count" = "5" ]; then
			echo "Load Factory Defaults!"
			ralink_init clear 2860
			ralink_init renew 2860 /etc_ro/Wireless/RT2860AP/RT2860_default_vlan
			reboot -f
		fi
	else
		count=0
	fi
	sleep 1
done
