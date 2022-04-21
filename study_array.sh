#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 10:50
# Version     : V1.0 
# Description : Study array            
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
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


# Test array
arr=(1 2 3 4 5)

for((a=0;a<${#arr[*]};a++))
do
	echo ${arr[a]}
done

echo "Wait 3 second..."
sleep 3

b=0
for b in ${arr[*]}
do
	echo ${arr[b]}
done

echo "Wait 3 second..."
sleep 3

c=0
while ((c<${#arr[*]}))
do
	echo ${arr[c]}
	((c++))
done
