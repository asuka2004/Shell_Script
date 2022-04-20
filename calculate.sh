#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 19:54
# Version     : V1.0
# Description : Sum Cal           
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

a=1
sum_a=0
while [ $a -lt 5 ]
do
	echo $a
 	((sum_a=sum_a+a))
 	((a++))
done
[ "$sum_a" -ne 0 ] && printf "Total Sum:$sum_a\n"

echo "wait 5 second................."
sleep 5

sum_b=0
for ((b=1;b<5;b++))
do
	echo $b
	((sum_b=sum_b+b))
done
[ "$sum_b" -ne 0 ] && printf "Total Sum: $sum_b\n"

echo "wait 5 second................."
sleep 5 

sum_c=0
for c in {1..4}
do
	echo $c
	((sum_c=sum_c+c))
	((c++))
done
[ "$sum_c" -ne 0 ] && printf "Total Sum: $sum_c\n"


