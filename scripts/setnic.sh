#!/bin/sh

MAC="52:54:00:12:34:59"
IP="192.168.0.70"

NIC=`ifconfig -a | grep -i ${MAC}  | tr -s ' ' | cut -d ' ' -f 1`

cat << _IFCFG > "/etc/sysconfig/network-scripts/ifcfg-${NIC}"

DEVICE="${NIC}"
TYPE="Ethernet"
ONBOOT="yes"
NM_CONTROLLED="yes"
BOOTPROTO="static"
IPADDR="${IP}"
#PREFIX=24
NETMASK="255.255.255.0"
#GATEWAY="192.168.0.1"
DNS1=8.8.8.8
DEFROUTE=yes
IPV4_FAILURE_FATAL="yes"
IPV6INIT="no"
IPV6_AUTOCONF="no"
NAME="System ${NIC}"
HWADDR="${MAC}"
_IFCFG

ifconfig ${NIC} up
service network restart