#!/bin/sh
# **************************************************
# Description  : Array study. Use kind of judgement    
# Build        : 2022-03-24 23:46
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

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
