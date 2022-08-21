#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 10:52
# Version     : V1.0
# Description : Create&Backup&Restore database on MySql5.7             
# System      : CentOS 7.9
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
#export MYSQL_PWD=${password}
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}
DBPATH=/root/tmp
[ ! -d "$DBPATH" ] && mkdir $DBPATH

SOCKET=/var/lib/mysql/mysql.sock
MYCMD="mysql --login-path=Kung -S $SOCKET -h localhost"
MYDUMP="mysqldump --login-path=Kung -S $SOCKET -h localhost --no-tablespaces --single-transaction"

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
	$MYCMD -e "use db2;truncate table test;"	
}

Restore_db(){
	gunzip ${DBPATH}/${dbname}_$(date +%F)/${dbname}.sql.gz 
	$MYCMD ${dbname}<${DBPATH}/${dbname}_$(date +%F)/${dbname}.sql	
}

Main(){
	echo "Create database and table. Please Wait ....."
	Create_db
	if [ $? -eq 0 ]
	 then
			action "Success to create db" /bin/true
	else
			action "Fail to create db and exit the script" /bin/false
			exit 2
	fi
	
	echo "Backup table. Please wait ........"
	Backup_db
	
	if [ $? -eq 0 ]
	 then
			action "Backup  db" /bin/true
	else
			action "Fail to bk db and exit the script" /bin/false
			exit 2
	fi

	echo "Del table.Please wait ........"
	Del_db	
	
	if [ $? -eq 0 ]
	 then
			action "delete  db" /bin/true
	else
			action "Fail to delete db and exit the script" /bin/false
			exit 2
	fi

	echo "Restore information Please wait....."
	Restore_db
	if [ $? -eq 0 ]
	 then
			action "restore  db" /bin/true
	else
			action "Fail to restore db and exit the script" /bin/false
			exit 2
	fi

}
Main $*
