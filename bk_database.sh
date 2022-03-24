#!/bin/sh
# **************************************************
# Description  : Backup table on Mysql5.6 
# Build        : 2022-03-24 23:17
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions
DBPATH=/root/tmp
MYUSER=root
MYPASS=P@ssw0rd
SOCKET=/var/lib/mysql/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET"
MYDUMP="mysqldump -u$MYUSER -p$MYPASS -S $SOCKET"

[ ! -d "$DBPATH" ] && mkdir $DBPATH

for dbname in `$MYCMD -e "show databases"|sed '1,2d'|egrep -v "mysql|schema|performance_schema|sys|information_schema"` 
do
 	mkdir $DBPATH/${dbname}_$(date +%F) -p
	for table in `$MYCMD -e "use $dbname;show tables from $dbname;"|sed '1,2d'`
	do
	$MYDUMP $dbname $table |gzip >$DBPATH/${dbname}_$(date +%F)/${dbname}_${table}.sql.gz
	done
done
