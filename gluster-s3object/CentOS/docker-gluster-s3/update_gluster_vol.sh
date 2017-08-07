#!/bin/bash

# To update gluster volume name in swift-volumes, used by swift-gen-builders.service
if [[ -z "$S3_ACCOUNT" || -z "$S3_USER" || -z "$S3_PASSWORD" ]]; then
        echo "You need to set S3_ACCOUNT, S3_USER, S3_PASSWORD env variable"
        exit 1
else
        echo "S3_ACCOUNT env variable is set. Update in swift-volumes"
        sed -i.bak '/^S3_ACCOUNT=/s/=.*/='\""$S3_ACCOUNT"\"'/' /etc/sysconfig/swift-volumes
	sed -i.bak '/^S3_USER=/s/=.*/='\""$S3_USER"\"'/' /etc/sysconfig/swift-volumes
	sed -i.bak '/^S3_PASSWORD=/s/=.*/='\""$S3_PASSWORD"\"'/' /etc/sysconfig/swift-volumes
fi

# Hand off to CMD
exec "$@"
