#!/bin/bash

set -e

HN=$1
INSTANCE_DIR=./${HN}

rm -rf ${INSTANCE_DIR}
rm -rf /var/run/${HN}.pid