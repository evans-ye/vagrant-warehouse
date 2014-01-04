#Taken from : https://cwiki.apache.org/confluence/display/BIGTOP/How+to+install+Hadoop+distribution+from+Bigtop+0.6.0
#A Vagrant recipe for setting up a hadoop box.

rpm -ivh http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm

yum -y install puppet-2.7.23-1.el6.noarch

wget -O /etc/yum.repos.d/bigtop.repo http://www.apache.org/dist/bigtop/bigtop-0.7.0/repos/centos6/bigtop.repo

service iptables stop

SERVER_IP=`/sbin/ifconfig | grep 'inet addr:' | grep -v 127.0.0.1 | grep -v 10.0.2.15 | head -n1 | cut -d: -f2 | awk '{print $1}'`;
HOST="$SERVER_IP $1"
[ `fgrep $HOST /etc/hosts | wc -l` -eq '0' ] && echo "$HOST" >> /etc/hosts

mkdir -p /data/{1,2}

mkdir /etc/puppet/config
cat > /etc/puppet/config/site.csv << EOF
hadoop_head_node,$1
hadoop_storage_dirs,/data/1,/data/2
bigtop_yumrepo_uri,http://bigtop.s3.amazonaws.com/releases/0.7.0/redhat/6/x86_64
jdk_package_name,java-1.7.0-openjdk-1.7.0.45
EOF

puppet apply -d --modulepath=/bigtop-puppet/modules /bigtop-puppet/manifests/site.pp

#su -s /bin/bash vagrant -c 'hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples*.jar pi 2 2'
