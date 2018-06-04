#!/bin/bash

###
# Description: Script to perform initial steps required for gluster-block.
# Copyright (c) 2017 Red Hat, Inc. <http://www.redhat.com>
#
# This file is part of GlusterFS.
#
# This file is licensed to you under your choice of the GNU Lesser
# General Public License, version 3 or any later version (LGPLv3 or
# later), or the GNU General Public License, version 2 (GPLv2), in all
# cases as published by the Free Software Foundation.
###

main () {
  GLUSTER_BLOCK_TARGET_CLI_BACKUP_DIR="/etc/target/backup"

  mkdir -p $GLUSTER_BLOCK_TARGET_CLI_BACKUP_DIR

  echo "Script Ran Successfully"
  exit 0
}
main
