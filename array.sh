#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 10:50
# Version     : V1.0
# Description : Test char less than 4            
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

array=( William Gilson not Tony Kung )
for ((i=0;i<${#array[*]};i++))
do
 	if [ ${#array[$i]} -lt 4 ]
	 then
		echo "${array[$i]}"
 	fi
done
