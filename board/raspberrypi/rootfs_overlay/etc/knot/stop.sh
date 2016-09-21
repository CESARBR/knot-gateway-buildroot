#!/bin/sh

PIDFILE=/tmp/$1.pid

if [ -e $PIDFILE ]
then
	PID=`cat $PIDFILE`
	rm $PIDFILE
	kill -15 $PID
else
	exit 1
fi
