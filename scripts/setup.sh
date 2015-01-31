#!/bin/bash

MOUNT_DIR=./mount
HN=$1
IP=$2
MACADDR=$3

device=$(/sbin/kpartx -av ./metadata_drive | cut -d " " -f3)
ls /dev/mapper/${device}

udevadm settle

mkdir -p ${MOUNT_DIR}

/bin/mount -t vfat /dev/mapper/${device} ${MOUNT_DIR}

echo "files in \"${MOUNT_DIR}\""
ls ${MOUNT_DIR}

echo "sed"
sed -i "s/HN=.*/HN=${HN}/" ${MOUNT_DIR}/init.sh
sed -i "s/MAC=.*/MAC=${MACADDR}/" ${MOUNT_DIR}/setnic.sh
sed -i "s/IP=.*/IP=${IP}/" ${MOUNT_DIR}/setnic.sh

echo "-------------"
cat ${MOUNT_DIR}/init.sh
cat ${MOUNT_DIR}/setnic.sh
echo "-------------"

/bin/umount -l ${MOUNT_DIR}