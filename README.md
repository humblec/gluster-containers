This repo contains dockerfiles (CentOS, Fedora, Red Hat) for GlusterFS containers.

Although Setting up a glusterfs environment is a pretty simple and straight forward procedure, Gluster community do maintain docker images for gluster both in Fedora and CentOS in the docker hub for the ease of users. This blog is intented to walk the user through the steps of running GlusterFS with the help of docker.
The community maintains docker images of GlusterFS release in both Fedora and CentOS distributions. The following are the steps to build the GlusterFS docker images that we maintain:
To pull the docker image from the docker hub run the following command:

### Fedora:

~~~
$ docker pull gluster/gluster-fedora

~~~

### CentOS:

~~~
$ docker pull gluster/gluster-centos

~~~
This will fetch and build the docker image for you from the docker hub.
Alternatively, one could build the image from the Dockerfile directly. For this, one should pull the Gluster-Fedora Dockerfile from the source repository and build the image using that. For getting the source, One can make use of git:

~~~
$ git clone git@github.com:gluster/gluster-containers.git
~~~

This repository consists of Dockerfiles for GlusterFS built in both CentOS and Fedora distributions. Once you clone the repository, to build the image, run the following commands:
For Fedora,

~~~
$ docker build -t gluster-fedora docker/Fedora/Dockerfile

~~~
For CentOS,
~~~
$ docker build -t gluster-centos docker/CentOS/Dockerfile
~~~
This command will build the docker image from the Dockerfile you just cloned and will be assigned the name gluster-fedora or gluster-centos respectively. ‘-t’ option is used to give a name to the image we are about the build.
Once the image is built in either of the above two steps, we can now run the container with gluster daemon running. For this run the command:

~~~
$ docker run -v /etc/glusterfs:/etc/glusterfs;z -v /var/lib/glusterd:/var/lib/glusterd:z -v /var/log/glusterfs:/var/log/glusterfs:z -v /sys/fs/group:/sys/fs/cgroup:ro -d --privileged=true --net=host -v /dev/:/dev gluster/gluster-centos
~~~

( is either gluster-fedora or gluster-centos as per the configurations so far)

Where:

        --net=host        ( Optional: This option brings maximum network throughput for your storage container)

        --privileged=true ( If you are exposing the `/dev/` tree of host to the container to create bricks from the container)
        
        
Bind mounting of following directories enables:

        `/var/lib/glusterd`     : To make gluster metadata persistent in the host.
        `/var/log/glusterfs`    : To make gluster logs persistent in the host.
        `/etc/glusterfs`        : To make gluster configuration persistent in the host.




Systemd has been installed and is running in the container we maintain. 

Once issued, this will boot up the Fedora or CentOS system and you have a container started with glusterd running in it.

##### Verify the container is running successfully:

~~~

$ docker ps -a

CONTAINER ID IMAGE COMMAND CREATED STATUS PORTS NAMES
d273cc739c9d gluster/gluster-fedora:latest "/usr/sbin/init" 3 minutes ago Up 3 minutes 49157/tcp, 49161/tcp, 49158/tcp, 38466/tcp, 8080/tcp, 2049/tcp, 24007/tcp, 49152/tcp, 49162/tcp, 49156/tcp, 6010/tcp, 111/tcp, 49154/tcp, 443/tcp, 49160/tcp, 38468/tcp, 49159/tcp, 245/tcp, 49153/tcp, 6012/tcp, 38469/tcp, 6011/tcp, 38465/tcp, 0.0.0.0:49153->22/tcp angry_morse
Note the Container ID of the image and inspect the image to get the IP address. Say the Container ID of the image is d273cc739c9d , so to get the IP do:
~~~

##### To inspect the container:

~~~
$ docker inspect d273cc739c9d

"GlobalIPv6Address": "",
"GlobalIPv6PrefixLen": 0,
"IPAddress": "172.17.0.2",
"IPPrefixLen": 16,
"IPv6Gateway": "",
"LinkLocalIPv6Address": "fe80::42:acff:fe11:2",
"LinkLocalIPv6PrefixLen": 64,
The IP address is “172.17.0.2”

~~~

##### Get inside the container

~~~
$ docker exec -ti d273cc739c9d

-bash-4.3# ps aux |grep glusterd
root 34 0.0 0.0 448092 15800 ? Ssl 06:01 0:00 /usr/sbin/glusterd -p /var/run/glusterd.pid
root 159 0.0 0.0 112992 2224 pts/0 S+ 06:22 0:00 grep --color=auto glusterd

-bash-4.3# gluster peer status
Number of Peers: 0

-bash-4.3# gluster --version

~~~
That’s it!


Additional Ref# https://goo.gl/3031Mm
