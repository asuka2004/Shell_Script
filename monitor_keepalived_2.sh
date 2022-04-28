#!/bin/bash
# Author      : Kung
# Build       : 2022-04-25 15:34
# Version     : V1.0
# Description :            
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}


VIP=192.168.88.27
PORT=80
IPVS=`rpm -qa ipvsadm|wc -l`

while true
do
	ping -w2 -c2 ${VIP} >/dev/null 2>&1

	if [ $? -ne 0 ]
	 then
		sh ./monitor_lvs.sh start >/dev/null 2>&1
	else
		sh ./monitor_lvs.sh stop >/dev/null 2>&1
	fi
	sleep 5
done
