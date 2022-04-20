#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 10:45
# Version     : V1.0
# Description : Array study. list array number           
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

for((a=0;a<${#array[*]};a++))
do
	echo ${array[a]}
done

echo "Wait 3 second..."
sleep 3

b=0
for b in ${array[*]}
do
	echo ${array[b]}
done

echo "Wait 3 second..."
sleep 3

c=0
while ((c<${#array[*]}))
do
	echo ${array[c]}
	((c++))
done
