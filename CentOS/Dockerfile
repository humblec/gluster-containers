FROM centos

MAINTAINER Humble Chirammal hchiramm@redhat.com

ENV container docker

RUN yum --setopt=tsflags=nodocs -y update; yum clean all;

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum --setopt=tsflags=nodocs -y install wget nfs-utils attr iputils iproute

RUN wget http://download.gluster.org/pub/gluster/glusterfs/3.7/LATEST/EPEL.repo/glusterfs-epel.repo -O /etc/yum.repos.d/glusterfs-epel.repo

RUN wget http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-6.noarch.rpm; rpm -ivh epel-release-7-6.noarch.rpm; rm epel-release-7-6.noarch.rpm;

RUN yum --setopt=tsflags=nodocs -y install glusterfs glusterfs-server glusterfs-geo-replication openssh-server

RUN yum clean all

RUN echo 'root:password' | chpasswd
VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 22 111 245 443 24007 2049 8080 6010 6011 6012 38465 38466 38468 38469 49152 49153 49154 49156 49157 49158 49159 49160 49161 49162 49163

RUN systemctl disable nfs-server.service
RUN systemctl enable rpcbind.service
RUN systemctl enable glusterd.service

CMD ["/usr/sbin/init"]
