#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 10:50
# Version     : V1.0 
# Description : Study array            
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}


arr=(1 2 3 4 5)

for((a=0;a<${#arr[*]};a++))
do
	echo ${arr[a]}
done

echo "Wait 5 second..."
sleep 5

b=0
for b in ${arr[*]}
do
	echo $b
	((b++))
done

echo "Wait 5 second..."
sleep 5

c=0
while ((c<${#arr[*]}))
do
	echo ${arr[c]}
	((c++))
done
