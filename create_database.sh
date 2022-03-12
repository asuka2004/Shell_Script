#!/bin/bash

PATH=/usr/bin/mysql
DBBK=/tmp
MYUSER=root
MYPASSWD=P@ssw0rd
MYSOCKET=/var/lib/mysql/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASSWD -S $MYSOCKET "
for dbname in test{1..100}
do
	echo $MYCMD -e "create database $dbname"
done 
