#!/bin/sh

DAEMON=/usr/local/bin/$1 

if [ -e $DAEMON ]
then
	while true
	do
		$DAEMON
	done &
	echo $! > /tmp/$1.pid
else
	exit 1
fi