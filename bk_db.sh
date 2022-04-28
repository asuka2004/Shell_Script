#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 10:52
# Version     : V1.0
# Description : Backup table on MySql5.6           
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

DBPATH=/root/tmp
MYUSER=Kung
MYPASS=P@ssw0rd
SOCKET=/var/lib/mysql/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET"
MYDUMP="mysqldump -u$MYUSER -p$MYPASS -S $SOCKET"

[ ! -d "$DBPATH" ] && mkdir $DBPATH

for dbname in `$MYCMD -e "show databases"|sed '1d'|egrep -v "mysql|schema|performance_schema|sys|information_schema"` 
do
 	mkdir -p $DBPATH/${dbname}_$(date +%F) 
	for table in `$MYCMD -e "use $dbname;show tables;"|sed '1d'`
	do
	$MYDUMP $dbname $table |gzip >$DBPATH/${dbname}_$(date +%F)/${dbname}_${table}.sql.gz
	done
done
