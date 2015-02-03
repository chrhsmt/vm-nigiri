#!/bin/bash

set -e

HN=$1
IP=$2
MACADDR=$3
INSTANCE_DIR=./${HN}
MOUNT_DIR=./mount
PUB_KEY=$4

mkdir -p ${INSTANCE_DIR}
cp ./metadata_drive ${INSTANCE_DIR}
cp ./start.sh ${INSTANCE_DIR}
cp ./vm.img ${INSTANCE_DIR}
cd ${INSTANCE_DIR}

device=$(/sbin/kpartx -av ./metadata_drive | cut -d " " -f3)
udevadm settle
ls /dev/mapper/${device}

mkdir -p ${MOUNT_DIR}

/bin/mount -o rw -t vfat /dev/mapper/${device} ${MOUNT_DIR}

echo "files in \"${MOUNT_DIR}\""
ls ${MOUNT_DIR}

sed -i "s/HN=.*/HN=${HN}/" ${MOUNT_DIR}/init.sh
sed -i "s/MAC=.*/MAC=${MACADDR}/" ${MOUNT_DIR}/setnic.sh
sed -i "s/IP=.*/IP=${IP}/" ${MOUNT_DIR}/setnic.sh

echo ${PUB_KEY} >> ${MOUNT_DIR}/authorized_keys

/bin/umount -l ${MOUNT_DIR}
echo "unmounted"
/sbin/kpartx -d ./metadata_drive
echo "kpartx -d done."