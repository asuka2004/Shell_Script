#!/bin/sh
# **************************************************
# Description  : Show Mysql5.7 database 
# Build        : 2022-03-23 22:35
# Author       : Kung
# Filename     : show_database.sh
# Version      : 1    
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

MYUSER=root
MYPASSWD=P@ssw0rd
MYSOCKET=/var/lib/mysql/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASSWD -S $MYSOCKET "
MYDUMP="mysqldump -u$MYUSER -p$MYPASSWD -S $MYSOCKET"
for dbname in `$MYCMD -u$MYUSER -p$MYPASSWD -S $MYSOCKET -e "show databases;"`
do
	echo $dbname  
done 
