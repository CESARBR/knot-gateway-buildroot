#!/bin/sh

PIDFILE=/tmp/$1.pid

if [ -e $PIDFILE ]
then
	PPID=`cat $PIDFILE`
	rm $PIDFILE
	PIDS=$PPID
	CHILD=`ps -eo pid,ppid|awk ' $2 == '$PPID' { print $1; }'`

	while [ "$CHILD" ]
	do
		CHILD=`ps -eo pid,ppid|awk ' $2 == '$PPID' { print $1 }'`
		PIDS="$PIDS $CHILD"
		PPID=$CHILD
	done
	kill -15 $PIDS
else
	exit 1
fi
