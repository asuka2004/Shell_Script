#!/bin/sh
# **************************************************
# Description  : Create a lot of database on MySql5.6 
# Build        : 2022-03-24 23:11
# Author       : Kung
# System       : CentOS 7.6 
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions
MYUSER=root
MYPASSWD=
MYSOCKET=/var/lib/mysql/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASSWD -S $MYSOCKET"
for name in `seq -w 10` 
do
	$MYCMD -e "create database db$name; show databases;"
done 
