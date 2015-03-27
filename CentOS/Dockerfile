FROM centos

MAINTAINER Humble Chirammal hchiramm@redhat.com

RUN yum --setopt=tsflags=nodocs -y install wget

RUN yum --setopt=tsflags=nodocs -y install nfs-utils

RUN wget http://download.gluster.org/pub/gluster/glusterfs/3.6/LATEST/CentOS/glusterfs-epel.repo -O /etc/yum.repos.d/glusterfs-epel.repo

RUN yum --setopt=tsflags=nodocs -y update

RUN yum --setopt=tsflags=nodocs -y install systemd
RUN yum --setopt=tsflags=nodocs -y install glusterfs glusterfs-server glusterfs-fuse glusterfs-geo-replication glusterfs-cli glusterfs-api
RUN yum --setopt=tsflags=nodocs -y install attr
RUN yum clean all

RUN ssh-keygen -A
RUN echo 'root:password' | chpasswd
VOLUME [ “/sys/fs/cgroup” ]

EXPOSE 22 111 245 443 24007 2049 8080 6010 6011 6012 38465 38466 38468 38469 49152 49153 49154 49156 49157 49158 49159 49160 49161 49162

CMD ["/usr/sbin/init"]
