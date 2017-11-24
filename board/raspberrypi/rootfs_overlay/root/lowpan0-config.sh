#! /bin/sh
#
# Copyright (c) 2017, CESAR.
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license. See the LICENSE file for details.
#

NODE=$1
ACK=$2

# Configuration
CHANNEL=12
PANID=0x23

NODE_SHORT=0x000
NODE_EXTENDED=DE:AD:BE:EF:BA:BE:00:0
NODE_IPV6=2001:db8:dead:beef

if [ -z "$NODE" ]
then
        if [ "$(hostname)" = "knot" ]
        then
                NODE=3
        fi
        if [ "$(hostname)" = "rpi3-4" ]
        then
                NODE=4
        fi
fi

if [ -z "$ACK" ]
then
        ACK=1
fi

echo Hostname: $(hostname)
#modprobe spi-bcm2835
modprobe at86rf230

#ifconfig wpan0 | grep -qs UP && ifconfig wpan0 down
ip link show wpan0 | grep -qs UP && ip link set wpan0 down

iwpan dev wpan0 del
iwpan phy phy0 interface add wpan0 type node $NODE_EXTENDED$NODE
ip link set wpan0 down
iwpan phy phy0 set channel 0 $CHANNEL
iwpan dev wpan0 set ackreq_default $ACK
iwpan dev wpan0 set pan_id $PANID
iwpan dev wpan0 set short_addr $NODE_SHORT$NODE
ip link add link wpan0 name lowpan0 type lowpan

#sysctl net.ipv6.conf.lowpan0.accept_dad=0 >> /dev/null
ip addr add $NODE_IPV6::$NODE/120 dev lowpan0
ip link set wpan0 up
ip link set lowpan0 up

#ifconfig wpan0 up
#ifconfig lowpan0 up
