#!/bin/sh

SSH=/root/.ssh
#SSH=/root/abc

#cd ~/.ssh
cd ${SSH}
rtn=`echo $?`
#echo $rtn

if [ $rtn -ne 0 ]
then
        mkdir -m 700 ${SSH}
fi

ls ${SSH}/authorized_keys
rtn=`echo $?`
#echo $rtn

if [ $rtn -ne 0 ]
then
        echo `cat /metadata/authorized_keys`>>${SSH}/authorized_keys
        chmod 600 ${SSH}/authorized_keys
        chown root ${SSH}/authorized_keys
fi