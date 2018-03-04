#!/bin/sh
#
# For HardWare Switch
#
# First 2012,12,04 Dingdong
#
# usage : switch.sh
#

count=0
flag=1
ap=0x2000
sta=0x0
default=0x3801

gpio=`gpio r | grep 13 | awk '{print $4}'`
if [ "$gpio" = "$ap" ]; then
	nvram_set OperationMode 1
else
	nvram_set OperationMode 2
fi
opmode=`nvram_get 2860 OperationMode`
echo "OperationMode=$opmode"

sleep 5
while [ "1" ]; do
if [ "$gpio" = "$ap" ]; then
	while [ "$flag" = "1" ]; do
		check_gpio=`gpio r | grep 13 | awk '{print $4}'`
		if [ "$check_gpio" = "$sta" ]; then
			echo "change to sta mode"
			reboot -f
		fi
		if [ "$count" = "5" ]; then
			flag=0
		fi
		count=`expr $count + 1`
		sleep 1	
	done
fi

count=0
flag=1
if [ "$gpio" = "$sta" ]; then
	while [ "$flag" = "1" ]; do
		check_gpio=`gpio r | grep 13 | awk '{print $4}'`
		if [ "$check_gpio" = "$ap" ]; then
			echo "change to ap mode"
			reboot -f
		fi
		if [ "$count" = "5" ]; then
			flag=0
		fi
		count=`expr $count + 1`
		sleep 1	
	done
fi

count=0
flag=1
done

