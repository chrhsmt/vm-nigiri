#!/bin/bash

MEMORY=1024
TELNET_PORT=4444
METADATA_DRIVE=./metadata_drive
MAC_ADDR=52:54:00:12:34:59

/usr/libexec/qemu-kvm \
-hda ./vm.img \
-m $MEMORY \
-monitor telnet::$TELNET_PORT,server,nowait \
-vnc :0 \
-daemonize \
-net nic,model=e1000,macaddr=$MAC_ADDR \
-net tap,ifname=tap0 \
-drive file=$METADATA_DRIVE