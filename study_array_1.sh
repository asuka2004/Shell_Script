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

# Test lengh less than 4 
array=( I am Tony Kung not William Gilson )

for ((a=0;a<${#array[*]};a++))
do
 	if [ ${#array[$a]} -lt 4 ]
	 then
		echo "${array[$a]}"
 	fi
done
			       
echo "Wait 3 second..."
sleep 3

b=0
while ((b<${#array[*]})) 
do
	if [ ${#array[$b]} -lt 4 ]
	 then
		echo "${array[$b]}"
	fi
	((b++))
done

c=0
for c in ${array[*]}
do
	if [ `expr length $c` -lt 4 ]
	 then
		echo $c
	fi
	((c++))
done

