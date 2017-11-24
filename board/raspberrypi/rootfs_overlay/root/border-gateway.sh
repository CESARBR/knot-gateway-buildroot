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
	NODE=1
fi

echo Border Gateway: $(hostname)
echo Border Gateway ID: ${NODE}

# Gateway scenario setup
sysctl -w net.ipv6.conf.all.forwarding=1
ip6tables -t nat -A POSTROUTING -j MASQUERADE

# Set Global Address on eth0 in Subnet 1
ip address add 2001:db8:b827:1::$NODE/64 dev eth0

# set Global Address on lowpan0 in Subnet 2
ip address add 2001:db8:b827:2::$NODE/64 dev lowpan0

# Add route for remote Host in Subnet 1
ip -6 route add 2001:db8:b827:1::/64 dev eth0

# Add route for remote Nodes in Subnet 2
ip -6 route add 2001:db8:b827:2::/64 dev lowpan0
