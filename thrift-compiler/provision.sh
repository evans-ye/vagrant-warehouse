#!/bin/bash

yum install automake libtool flex bison pkgconfig gcc-c++ boost-devel libevent-devel zlib-devel python-devel ruby-devel

wget http://apache.cdpa.nsysu.edu.tw/thrift/0.9.1/thrift-0.9.1.tar.gz
tar zxvf thrift-0.9.1.tar.gz -C /root/
(cd thrift-0.9.1/test/cpp;  cp *.o .libs/;) 
(cd thrift-0.9.1; ./configure;)
(cd thrift-0.9.1; make;)
(cd thrift-0.9.1; make install;)
