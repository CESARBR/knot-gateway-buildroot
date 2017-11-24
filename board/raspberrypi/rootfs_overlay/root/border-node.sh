#! /bin/sh
#
# Copyright (c) 2017, CESAR.
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license. See the LICENSE file for details.
#

NODE=$1
NODE_REMOTE=$2

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

if [ -z "$NODE_REMOTE" ]
then
        if [ "$NODE" = "3" ]
        then
                NODE_REMOTE=4
        fi
        if [ "$NODE" = "4" ]
        then
                NODE_REMOTE=3
        fi
fi

echo Node: $(hostname)

# set ULA on lowpan0
ip address add fd2d:0388:6a7b:2::$NODE/120 dev lowpan0

# Add route for gateway
ip -6 route add fd2d:388:6a7b:2::NODE_REMOTE/120 dev lowpan0

# Add route for Remote Host
ip -6 route add fd2d:388:6a7b:1::/120 via fd2d:388:6a7b:2::$NODE_REMOTE
