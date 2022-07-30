#!/bin/bash
# Author      : Kung
# Build       : 2022-06-16 23:21
# Version     : V1.0
# Description : If nginx fail ,stop keepalived            
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

if [ `netstat -ntulp|grep nginx|wc -l` -gt 0 ];then
	echo  "Web is running"  
else
	echo "Web will reboot"
	/usr/bin/systemctl restart nginx
fi
