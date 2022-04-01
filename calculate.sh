#!/bin/sh
# **************************************************
# Description  : Calculate sum 
# Build        : 2022-03-24 23:40
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

i=1
sum=0
while [ $i -lt 5 ]
do
 	((sum=sum+i))
 	((i++))
done
[ "$sum" -ne 0 ] && printf "Total sum is:$sum\n"


echo " "

sun=0
for ((i=1;i<5;i++))
do
	((sun=sun+i))
done
[ "$sum" -ne 0 ] && printf "Total sum is:$sum\n"
 
