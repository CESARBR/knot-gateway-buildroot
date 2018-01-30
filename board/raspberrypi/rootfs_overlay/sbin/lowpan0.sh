#!/bin/sh
/sbin/ip link add link wpan0 name lowpan0 type lowpan
/sbin/ip addr flush dev lowpan0
/sbin/ip addr add fe80::1/64 dev lowpan0
/sbin/ip link set lowpan0 up
