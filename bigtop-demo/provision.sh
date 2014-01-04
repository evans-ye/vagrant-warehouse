#!/bin/bash

GUEST_FOLDER=$1
echo "SHARED_FOLDER:$GUEST_FOLDER"
echo "HOSTNAME:$2"

# oracle jdk
bash $GUEST_FOLDER/jdk-6u45-linux-x64-rpm.bin
rpm -ivh $GUEST_FOLDER/epel-release-6-8.noarch.rpm

# puppet
yum -y install puppet

# prepare storage dirs
mkdir -p /data/1 /data/2

# os level setup
echo "alias jps=/usr/java/jdk1.6.0_45/bin/jps" >> ~/.bashrc
service iptables stop

# bigtop deploy
yum install -y git
git clone https://github.com/apache/bigtop.git
mkdir /etc/puppet/config
cat > /etc/puppet/config/site.csv << EOF
hadoop_head_node,$2
hadoop_storage_dirs,/data/1,/data/2
bigtop_yumrepo_uri,http://bigtop.s3.amazonaws.com/releases/0.7.0/redhat/6/x86_64
EOF
puppet apply -d --modulepath=bigtop/bigtop-deploy/puppet/modules bigtop/bigtop-deploy/puppet/manifests/site.pp
