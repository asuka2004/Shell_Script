#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 20:02
# Version     : V1.0
# Description : Monitor memorycache           
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

if [ `netstat -ntulp|grep 11211 |wc -l` -lt 1 ]
 then
	echo "Memcache is error"
	exit 1
fi

printf "del key\r\n"| nc -v 127.0.0.1 11211 &>/dev/null
printf "set key 0 0 10 \r\n\r\n"| nc -v 127.0.0.1 11211 &>/dev/null
McValues=`printf "get key\r\n"|nc -v 127.0.0.1 11211|grep |wc -l`

if [ $McValues -eq 1 ]
 then
	echo "Memorycache is ok"
else
	echo "Memorycache fail"
fi
