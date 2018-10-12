#!/bin/bash
#
# Create a fake-disk for use with Gluster.
#
# Copyright (c) 2018 Red Hat, Inc. <http://www.redhat.com>
#
# This file is part of GlusterFS.
#
# This file is licensed to you under your choice of the GNU Lesser
# General Public License, version 3 or any later version (LGPLv3 or
# later), or the GNU General Public License, version 2 (GPLv2), in all
# cases as published by the Free Software Foundation.
#

# Note: environment variables might need to listed in the systemd .service as
# well, see PassEnvironment in gluster-fake-disk.service and systemd.exec(5).
#
# Set the USE_FAKE_DISK environment variable in the container deployment
#USE_FAKE_DISK=1
# You should also have a bind-mount for /srv in case data is expected to stay
# available after restarting the glusterfs-server container.
FAKE_DISK_FILE=${FAKE_DISK_FILE:-/srv/fake-disk.img}
FAKE_DISK_SIZE=${FAKE_DISK_SIZE:-10G}
FAKE_DISK_DEV=${FAKE_DISK_DEV:-/dev/fake}

# Create the FAKE_DISK_FILE with fallocate, but only do so if it does not exist
# yet.
create_fake_disk_file () {
  [ -e "${FAKE_DISK_FILE}" ] && return 0
  truncate --size "${FAKE_DISK_SIZE}" "${FAKE_DISK_FILE}"
}

# Setup a loop device for the FAKE_DISK_FILE, and create a symlink to /dev/fake
# so that it has a stable name and can be used by other components (/dev/loop*
# is numbered based on other existing loop devices).
setup_fake_disk () {
  local fakedev

  fakedev=$(losetup --find --show "${FAKE_DISK_FILE}")
  [ -e "${fakedev}" ] && ln -fs "${fakedev}" "${FAKE_DISK_DEV}"
}

if [ -n "${USE_FAKE_DISK}" ]
then
  if ! create_fake_disk_file
  then
    echo "failed to create a fake disk at ${FAKE_DISK_FILE}"
    exit 1
  fi

  if ! setup_fake_disk
  then
    echo "failed to setup loopback device for ${FAKE_DISK_FILE}"
    exit 1
  fi
fi
