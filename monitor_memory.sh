#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 19:52
# Version     : V1.0
# Description : Monitor memory           
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

Memory=`free -m|awk 'NR==2 {print $NF}'`
Alarm="Warining!!! Current time is `date +%F-%T` and Memory leave over $Memory"
if [ $Memory -lt 13500 ]
 then
	echo $Alarm>> /root/tmp/message.txt
	mail -s "$Alarm" root@localhost</root/tmp/message.txt
fi
 
