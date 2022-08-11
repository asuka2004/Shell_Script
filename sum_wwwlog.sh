#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 21:08
# Version     : V1.0
# Description : Log sum           
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

sum=0
exec<$1
while read line
do
 size=`echo $line |awk '{print $10}'`
 expr $size + 1 &>/dev/null
 if [ $? -ne 0 ]
  then
	continue
 fi
 ((sum=sum+$size))
done
echo "Total: `echo $((${sum}/1024)) KB`"
