#! /bin/sh
#
# Copyright (c) 2017, CESAR.
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license. See the LICENSE file for details.
#

NODE=$1

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

echo Border Gateway: $(hostname)

# gateway scenario setup
sysctl -w net.ipv6.conf.all.forwarding=1

# set ULA on eth0
ip address add fd2d:388:6a7b:1::$NODE/120 dev eth0

# add route for remote host
ip -6 route add fd2d:388:6a7b:1::/120 dev eth0

# set ULA on lowpan0
ip address add fd2d:388:6a7b:2::$NODE/120 dev lowpan0
