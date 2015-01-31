#!/bin/bash

HN=vm_syake_`date +%Y%m%d%H%M%S`

if ! grep -q "HOSTNAME=$HN" /etc/sysconfig/network ; then
  sed -i "s/HOSTNAME=.*/HOSTNAME=$HN/" /etc/sysconfig/network
fi

if ! grep -q "$HN" /etc/hosts ; then
  sed -i "/127.0.0.1.*localhost/a\127.0.0.1 $HN" /etc/hosts
fi