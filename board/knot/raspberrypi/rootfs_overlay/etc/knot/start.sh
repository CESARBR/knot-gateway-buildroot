#!/bin/sh

DAEMON=/usr/local/bin/$1
RUN=/usr/local/bin/$@

echo "void" > /tmp/$1.pid

if [ -x $DAEMON ]
then
	while [ -e /tmp/$1.pid ]
	do
		$RUN
	done &
	echo $! > /tmp/$1.pid
else
	exit 1
fi
