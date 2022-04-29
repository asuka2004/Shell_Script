#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 19:49
# Version     : V1.0
# Description : Batch to create database&table           
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

MYUSER=Kung
MYPASSWD=
MYSOCKET=/var/lib/mysql/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASSWD -S $MYSOCKET"
for name in `seq -w 10` 
do
	$MYCMD -e "create database db$name; show databases;"
done 
