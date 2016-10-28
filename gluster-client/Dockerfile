FROM fedora 
MAINTAINER Humble Devassy Chirammal  <hchiramm@redhat.com> 
LABEL Name="glusterfs-client"
ENV container docker
RUN dnf --setopt=tsflags=nodocs -y update; dnf clean all; dnf --setopt=tsflags=nodocs -y install wget nfs-utils attr iputils iproute;
RUN sed -i "s/LANG/\#LANG/g" /etc/locale.conf
RUN dnf install -y glusterfs-fuse; dnf clean all;
CMD ["/bin/bash"]
