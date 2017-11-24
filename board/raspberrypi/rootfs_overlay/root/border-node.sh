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
	NODE=2
fi

if [ "$NODE" -eq "$NODE_REMOTE" ]
then
	NODE_REMOTE=1
	NODE=2
	echo Changing Node ID and Gateway ID: They were equal.
fi

if [ -z "$NODE_REMOTE" ]
then
	NODE_REMOTE=1
fi

echo Node: $(hostname)
echo Border Node ID: ${NODE}
echo Border Gateway ID: ${NODE_REMOTE}

# set Gobal Address on lowpan0 in Subnet 2
ip address add 2001:db8:b827:2::$NODE/64 dev lowpan0

# Add route for Gateway
ip -6 route add 2001:db8:b827:2::$NODE_REMOTE/64 dev lowpan0

# Add route for remote Host
ip -6 route add 2001:db8:b827:1::/64 via 2001:db8:b827:2::$NODE_REMOTE
