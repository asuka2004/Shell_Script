#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 21:05
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

for n in {0..10}
do
	echo "`echo $n|md5sum` $n" >>/root/github/md5sum.log
done


md5search="fdd96b0a2ea29515"
while read line
do
	if [ `echo $line|grep "$md5search"|wc -l` -eq 1 ];then
	echo $line
	break
	fi
done</root/github/md5sum.log

