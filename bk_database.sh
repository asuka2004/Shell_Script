#!/bin/bash
PATH=$PATH
export PATH
#PATH=/usr/bin/mysql
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
