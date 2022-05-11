#!/bin/bash
# Author      : Kung
# Build       : 2022-05-11 23:27
# Version     : V1.0
# Description : Study break continue exit return           
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
	echo "Please input {break|continue|exit|return}"
	exit 1
fi

test(){
 for ((i=0;i<=5;i++))
 do
	if [ $i -eq 3 ];then
		$*	
	fi
	echo $i	
 done
 echo "I am in func"
}
test $*
 
