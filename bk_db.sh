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
MYUSER=Kung
MYPASS=P@ssw0rd
SOCKET=/var/lib/mysql/mysql.sock
MYCMD="mysql -u$MYUSER -p$MYPASS -S $SOCKET -h localhost"
MYDUMP="mysqldump -u$MYUSER -p$MYPASS -S $SOCKET -h localhost --no-tablespaces --single-transaction"

[ ! -d "$DBPATH" ] && mkdir $DBPATH

Create_db(){
	
	for num in `seq -w 05` 
	do
		$MYCMD -e "create database company$num;use company$num;create table dept(deptnu int primary key,dname VARCHAR(50),addr VARCHAR(50)) engine='InnoDB' DEFAULT CHARSET=utf8;create table employee(empno INT PRIMARY KEY ,ename VARCHAR(50) ,job VARCHAR(50),mgr INT ,hiredate DATE ,sal DECIMAL(4.2) ,deptnu INT ,foreign key (deptnu) references dept(deptnu)) engine='InnoDB' DEFAULT CHARSET=utf8;CREATE TABLE salgrade(grade INT PRIMARY KEY,lowsal INT ,highsal INT) engine='InnoDB' DEFAULT CHARSET=utf8;"
	done
}

Backup_db(){
	for dbname in `$MYCMD -e "show databases;"|sed '1d'|egrep -v "mysql|schema|performance_schema|sys|information_schema"` 
	do
 		mkdir -p $DBPATH/${dbname}_$(date +%F) 
		$MYDUMP $dbname |gzip >$DBPATH/${dbname}_$(date +%F)/${dbname}.sql.gz
	done
}

Restore_db(){
	for dbname in `$MYCMD -e "show databases"|sed '1d'|egrep -v "mysql|schema|performance_schema|sys|information_schema"` 
	do
		gunzip ${DBPATH}/${dbname}_2022-05-03/${dbname}.sql.gz 
		$MYCMD ${dbname}<${DBPATH}/${dbname}_$(date +%F)/${dbname}.sql	
	done
}

Main(){
	Create_db
	echo "Wait 5 second....."
	sleep 5
	Backup_db
	echo "Wait 5 second....."
	sleep 5
	Restore_db	
}
Main

