#!/bin/sh

PIDFILE=/tmp/$1.pid

if [ -e $PIDFILE ]
then
    kill -15 -`cat $PIDFILE`
    rm $PIDFILE
else
	exit 1
fi