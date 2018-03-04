#!/bin/sh
#
# For exec cstreamer
#
# usage: enable_stream.sh
#

opmode=`nvram_get OperationMode`
enableWiFi_IP=`ifconfig ra0 | grep 'inet addr' | awk '{print $2}' | sed -e "s/addr\://"`
enableWAN_IP=`ifconfig eth2.2 | grep 'inet addr' | awk '{print $2}' | sed -e "s/addr\://"`

if [ "$opmode" == "1" ]; then
	if [ "$enableWAN_IP" == "" ]; then
		echo "br0"
		sleep 1
		cstreamer -i br0 -c /bin/EyeOn39.conf &
	else
    	echo "eth2.2"
		cstreamer -i eth2.2 -c /bin/EyeOn39.conf &
	fi
else
	if [ "$enableWiFi_IP" == "" ]; then
		echo "eth2.1"
		cstreamer -i eth2.1 -c /bin/EyeOn39.conf &
	else
		echo "ra0"
		cstreamer -i ra0 -c /bin/EyeOn39.conf &	
	fi	
fi


