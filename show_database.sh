#!/bin/bash

PATH=/usr/bin/mysql
DBBK=/tmp
MYUSER=root
MYPASSWD=P@ssw0rd
MYSOCKET=/var/lib/mysql/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASSWD -S $MYSOCKET "
DUMP="mysqldump -u$MYUSER -p$MYPASSWD -S $MYSOCKET"
[ ! -d "$DBBK" ] && mkdir $DBBK
for dbname in `$PATH -u$MYUSER -p$MYPASSWD -S $MYSOCKET -e "show databases;"`
do
	echo $dbname  
done 
