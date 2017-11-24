#! /bin/sh
#
# Copyright (c) 2017, CESAR.
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license. See the LICENSE file for details.
#

BORDER_GATEWAY=$1

if [ -z "$BORDER_GATEWAY" ]
then
        BORDER_GATEWAY=1
fi

echo Remote Host: $(hostname)

# Set ULA address
ip address add fd2d:388:6a7b:1::2/120 dev enp0s3

# Add route for gateway
ip -6 route add fd2d:388:6a7b:1::$BORDER_GATEWAY/120 dev enp0s3

# Add route for IoT devices
ip -6 route add fd2d:388:6a7b:2::/120 via fd2d:388:6a7b:1::$BORDER_GATEWAY
