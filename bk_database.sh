#!/bin/bash
PATH=/usr/bin/mysql
DBPATH=/root/tmp
MYUSER=root
MYPASS=P@ssw0rd
SOCKET=/var/lib/mysql/mysql.sock
MYCMD="$PATH -u$MYUSER -p$MYPASS -S $SOCKET"
MYDUMP="/usr/bin/mysqldump -u$MYUSER -p$MYPASS -S $SOCKET"

[ ! -d "$DBPATH" ] && mkdir $DBPATH

for dbname in `$MYCMD -e "show databases"| /usr/bin/grep db*` 
do
 $MYDUMP $dbname| /usr/bin/gzip >$DBPATH/${dbname}.$(/usr/bin/date +%F).sql.gz
done
