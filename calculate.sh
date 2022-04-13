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

i=1
sum_a=0
while [ $i -lt 5 ]
do
 	((sum_a=sum_a+i))
 	((i++))
done
[ "$sum_a" -ne 0 ] && printf "Total Sum is: $sum_a\n"


echo " "

sum_b=0
for ((i=1;i<5;i++))
do
	((sum_b=sum_b+i))
done
[ "$sum_b" -ne 0 ] && printf "Total Sum is: $sum_b\n"
 
