#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 10:52
# Version     : V1.0
# Description : Create&Backup&Restore database on MySql5.6             
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
[ ! -d "$DBPATH" ] && mkdir $DBPATH
MYUSER=Kung
MYPASS=P@ssw0rd
SOCKET=/var/lib/mysql/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET -h localhost"
MYDUMP="mysqldump -u$MYUSER -p$MYPASS -S $SOCKET -h localhost --no-tablespaces --single-transaction"

Create_db(){
	$MYCMD -e "create database db2;use db2;create table test(id int(7) zerofill auto_increment not null,username varchar(20),servnumber varchar(30),password varchar(20),createtime datetime,primary key (id))DEFAULT CHARSET=utf8;source /root/tmp/sql.txt;"
}

Backup_db(){
	for dbname in `$MYCMD -e "show databases;"|sed '1d'|egrep -v "mysql|schema|performance_schema|sys|information_schema"` 
	do
 		mkdir -p $DBPATH/${dbname}_$(date +%F) 
		$MYDUMP $dbname |gzip >$DBPATH/${dbname}_$(date +%F)/${dbname}.sql.gz
	done
}

Del_db(){
	$MYCMD -e "use db1;truncate table employee;"	
}

Restore_db(){
	gunzip ${DBPATH}/${dbname}_$(date +%F)/${dbname}.sql.gz 
	$MYCMD ${dbname}<${DBPATH}/${dbname}_$(date +%F)/${dbname}.sql	
}

Main(){
	Create_db
	echo "Wait 10 second....."
	sleep 10
	Backup_db
	echo "Wait 5 second....."
	sleep 5
	Del_db	
	echo "Wait 5 second....."
	sleep 5
	Restore_db
}
Main

