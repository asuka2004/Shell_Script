#!/bin/bash
# Author      : Kung
# Build       : 2022-08-13 20:03
# Version     : V1.0
# Description : Use expect file to copy file           
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

if [ $# -ne 2 ]
 then
	echo $"Usage:$0 file dir"
	exit
fi
file=$1
dir=$2

for n in 101 102 
do
	expect scp_remote.exp $file 192.168.88.$n $dir
done
