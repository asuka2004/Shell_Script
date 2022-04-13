#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 10:45
# Version     : V1.0
# Description : Array study. Use kind of judgement           
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

array=(1 2 3 4 5)

for((i=0;i<${#array[*]};i++))
do
	echo ${array[i]}
done

for n in ${array[*]}
do
	echo $n
done

m=0
while ((m<${#array[*]}))
do
	echo ${array[m]}
	((m++))
done
