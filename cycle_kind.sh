#!/bin/bash
# **************************************************
# Description  : any kind of if& while 
# Build        : 2022-04-08 19:44
# Author       : Kung
# System       : CentOS7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

for ((i=1;i<5;i++))
do
	echo $i
done

k=1
while ((k<5))
do
	echo $k
	((k++))
done

j=1
for j in {1..4}
do
	echo $j
	((j++))
done
