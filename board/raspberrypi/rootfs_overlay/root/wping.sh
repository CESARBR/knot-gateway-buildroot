#! /bin/sh
#
# Copyright (c) 2017, CESAR.
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license. See the LICENSE file for details.
#

NODE=$1
SIZE_PCKT=$2

NODE_SHORT=0x000

if [ -z "$NODE" ]
then
	echo Hostname: $(hostname)
	if [ "$(hostname)" = "rpi3-3" ]
	then
		NODE=4
	fi
	if [ "$(hostname)" = "rpi3-4" ]
	then
		NODE=3
	fi
fi

if [ -z "$SIZE_PCKT" ]
then
	SIZE_PCKT=5
fi

if [ "$NODE" = "4" ]
then
	#Server side:
	wpan-ping -d $NODE_SHORT$NODE
fi

if [ "$NODE" = "3" ]
then
	#Client side:
	wpan-ping -a $NODE_SHORT$NODE -c 5 -s $SIZE_PCKT
fi
