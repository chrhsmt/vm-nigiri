#!/bin/bash

set -e

MEMORY=$1
METADATA_DRIVE=$(dirname $0)/metadata_drive
MAC_ADDR=$2
NAME=$3
TELNET_PORT=$4

/usr/libexec/qemu-kvm \
-hda $(dirname $0)/vm.img \
-m $MEMORY \
-monitor telnet::$TELNET_PORT,server,nowait \
-daemonize \
--pidfile /var/run/${NAME}.pid \
-net nic,model=e1000,macaddr=$MAC_ADDR \
-net tap,ifname=tap_${NAME} \
-drive file=$METADATA_DRIVE

#-vnc :0 \
