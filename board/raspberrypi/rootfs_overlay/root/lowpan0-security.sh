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

# Configuration
PANID=0x23
PANID_BROADCAST=0xffff
NODE_SHORT=0x000
NODE_SHORT_BROADCAST=0xffff
NODE_EXTENDED=0xdeadbeefbabe000
FRAME_COUNTER=0
KEY=f0:e1:d2:c3:b4:a5:96:87:78:69:5a:4b:3c:2d:1e:0f

#Key ids
KEY_ID_MODE_IMPLICIT=0
KEY_ID_MODE_INDEX=1
KEY_ID_MODE_INDEX_SHORT=2
KEY_ID_MODE_INDEX_EXTENDED=3

ADDR_NONE=0
ADDR_SHORT=2
ADDR_LONG=3

#Security level
SECLEVEL_NONE=0
SECLEVEL_MIC32=1
SECLEVEL_MIC64=2
SECLEVEL_MIC128=3
SECLEVEL_ENC=4
SECLEVEL_ENC_MIC32=5
SECLEVEL_ENC_MIC64=6
SECLEVEL_ENC_MIC128=7

SECLEVELS=$(((1<<($SECLEVEL_ENC))+(1<<($SECLEVEL_MIC32))+(1<<($SECLEVEL_ENC_MIC32))))
SECLEVEL=$SECLEVEL_ENC_MIC32

#Frame types
FRAME_BEACON=0
FRAME_DATA=1
FRAME_ACK=2
FRAME_CMD=3
FRAME_TYPES=$((1<<($FRAME_DATA)))

#Key mode
DEVKEY_IGNORE=0
DEVKEY_RESTRICT=1
DEVKEY_RECORD=2

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

echo Hostname: $(hostname)
echo Node: $NODE
echo NodeRemote: $NODE_REMOTE

#Setup for local
iwpan dev wpan0 set security 1
iwpan dev wpan0 set out_key_id $KEY_ID_MODE_IMPLICIT $PANID $ADDR_SHORT $NODE_SHORT$NODE
iwpan dev wpan0 set out_level $SECLEVEL

#Setup for remotes
iwpan dev wpan0 seclevel add $SECLEVELS $FRAME_DATA 0
iwpan dev wpan0 device add $FRAME_COUNTER $PANID $NODE_SHORT$NODE_REMOTE $NODE_EXTENDED$NODE_REMOTE 0 $DEVKEY_RESTRICT
iwpan dev wpan0 devkey add $FRAME_COUNTER $NODE_EXTENDED$NODE_REMOTE $KEY_ID_MODE_IMPLICIT $PANID $ADDR_SHORT $NODE_SHORT$NODE_REMOTE
iwpan dev wpan0 key add $FRAME_TYPES $KEY $KEY_ID_MODE_IMPLICIT $PANID $ADDR_SHORT $NODE_SHORT$NODE_REMOTE
iwpan dev wpan0 key add $FRAME_TYPES $KEY $KEY_ID_MODE_IMPLICIT $PANID $ADDR_SHORT $NODE_SHORT_BROADCAST

iwpan dev
iwpan dev wpan0 seclevel dump
iwpan dev wpan0 device dump
iwpan dev wpan0 devkey dump
iwpan dev wpan0 key dump
