#!/bin/bash
vagrant ssh -c "sudo su -s /bin/bash hdfs -c 'hadoop fs -mkdir /user/vagrant && hadoop fs -chown vagrant:vagrant /user/vagrant'"
vagrant ssh -c "hadoop jar /usr/lib/hadoop-mapreduce/hadoop-mapreduce-examples.jar pi 2 2"
