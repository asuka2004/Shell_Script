#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 19:48
# Version     : V1.0
# Description : Check Web is normal or not           
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

if [ $# -ne 1 ]
 then
 	echo $"usage $0 url"
 	exit 1
fi

while true
do
 if [ `curl -o /dev/null --connect-timeout 5 -s -w "%{http_code}" $1|egrep -w "200|301|302"|wc -l` -ne 1 ]
	then
	 action "$1 is error" /bin/false
 else
	 action "$1 is ok" /bin/true
 fi
 sleep 5
done
