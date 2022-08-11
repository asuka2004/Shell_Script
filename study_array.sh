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

c=0
while ((c<${#array[*]})) 
do
	if [ ${#array[$c]} -lt 4 ]
	 then
		echo "${array[$c]}"
	fi
	((c++))
done

#k=0
for k in ${array[*]}
do
	if [ ${#array[$k]} -lt 4 ];then
		echo "${array[$k]}"
	fi
	((k++))
done

# Test array
arr=(1 2 3 4 5)

for((d=0;d<${#arr[*]};d++))
do
	echo ${arr[d]}
done

echo "Wait 5 second..."
sleep 5

e=0
for e in ${arr[*]}
do
	echo ${arr[e]}
	((e++))
done

echo "Wait 5 second..."
sleep 5

f=0
while ((f<${#arr[*]}))
do
	echo ${arr[f]}
	((f++))
done
