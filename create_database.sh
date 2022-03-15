#!/bin/bash
export PATH=$PATH
MYUSER=root
MYPASSWD=P@ssw0rd
MYSOCKET=/var/lib/mysql/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASSWD -S $MYSOCKET"
for name in `seq -w 10` 
do
	$MYCMD -e "create database windows$name;"
done 
