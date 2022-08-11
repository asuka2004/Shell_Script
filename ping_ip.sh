#!/bin/bash
# Author      : Kung
# Build       : 2022-04-16 11:41
# Version     : V1.0
# Description : Ping IP
# System      : CentOS 7.9
export PS4='++ ${LINENO} '
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

CMD="ping -w 2 -c 2"
IP="192.168.88."
for N in `seq 50` 
do
	$CMD $IP$N &>/dev/null
	if [ $? -eq 0 ]
	 then
		action "Success to ping $IP$N" /bin/true
	else
		action "Fail to ping $IP$N" /bin/false
	fi
done
