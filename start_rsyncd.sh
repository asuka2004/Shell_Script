#!/bin/bash
# Author      : Kung
# Build       : 2022-05-22 16:39
# Version     : V1.0
# Description : Start Rsync           
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

if [ $# -ne 1 ]
 then
	echo $"Usage:$0 {Start|Stop|Restart}"
	exit 1
fi

if [ "$1" = "Start" ]
 then
	systemctl start rsyncd
	sleep 2
	if [ `netstat -ntulp|grep rsync|wc -l` -ge 1 ]
	 then
		echo "Rsync started"
		exit 0
	fi
elif [ "$1" = "Stop" ]
 then
	systemctl stop rsyncd 
	sleep 2
	if [ `netstat -ntulp| grep rsync|wc -l` -eq 0 ]
	 then
		echo "Rsync is Stopped"
		exit 0
	fi

elif [ "$1" = "$Restart" ]
 then
	systemctl stop rsyncd	
	sleep 1
	killpro=`netstat -ntulp|grep rsync|wc -l`
	systemctl start rsyncd
	sleep 1
	startpro=`netstat -ntulp| grep rsync|wc -l`
	if [ $killpro -eq 0 -a $startpro -ge 1 ]
	 then
		echo "Rsyncd is Restarted"
		exit 0
	fi

else
	echo $"Usage:$0 {Start|Stop|Restart}"
	exit 1	
fi



