# gluster-fedora Docker image

GlusterFS on Fedora

## Tags

* `latest` ([Dockerfile](https://github.com/jarrpa/gluster-containers/tree/fedora-update/Fedora)):
  Latest stable image

## Description

GlusterFS is a distributed and scalable network filesystem. Using common, off-the-shelf hardware you can create large, distributed storage solutions for media streaming, data analysis, and other data- and bandwidth-intensive tasks.

## Support for fake disks

This container offers several configuration options that make it easier to test
the functionality. It is possible to configure a fake disk so that there is no
requirement for additional block devices on the container host. The container
has a `gluster-fake-disk` service that consumes the following environment
variables:

- `USE_FAKE_DISK` (default is empty) when set to a non-empty value, setup a
  fake disk. The other environment variables have defaults and do not need to
  be set.

- `FAKE_DISK_FILE` (defaults to `/srv/fake-disk.img`) the fake disk will be
  backed by this file. To have persistent storage, make sure to have the
  directory where this file is located bind-mounted as a volume in the
  container.

- `FAKE_DISK_SIZE` (defaults to `10G`) sets the size of the `FAKE_DISK_FILE`
  through `truncate` in case the file does not exist.

- `FAKE_DISK_DEV` (defaults to `/dev/fake`) the device node under `/dev` that
  should be provided for the disk. This will be a symlink to the `/dev/loop<N>`
  loopback device.

