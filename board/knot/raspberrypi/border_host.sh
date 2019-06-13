#! /bin/sh
#
# Copyright (c) 2017, CESAR.
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license. See the LICENSE file for details.
#

BORDER_GATEWAY=$1
NODE=$2

if [ -z "$BORDER_GATEWAY" ]
then
        BORDER_GATEWAY=1
fi

if [ "$NODE" -eq "$BORDER_GATEWAY" ]
then
        BORDER_GATEWAY=1
        NODE=2
        echo Changing Host ID and Gateway ID: They were equal.
fi

if [ -z "NODE" ]
then
	NODE=2
fi

echo Remote Host: $(hostname)
echo Host ID: ${NODE}
echo Gateway ID: ${BORDER_GATEWAY}

# Set Global Address in Subnet 1
ip address add 2001:db8:b827:1::$NODE/64 dev eth0

# Add route for Gateway
ip -6 route add 2001:db8:b827:1::$BORDER_GATEWAY/64 dev eth0

# Add route for Remote Nodes
ip -6 route add 2001:db8:b827:2::/64 via 2001:db8:b827:1::$BORDER_GATEWAY dev eth0
