#!/bin/sh
# **************************************************
# Description  : char less than 4 
# Build        : 2022-03-25 22:52
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

array=(  gilson not tony kung  i m )
for ((i=0;i<${#array[*]};i++))
do
 	if [ ${#array[$i]} -lt 4 ]
	 then
		echo "${array[$i]}"
 	fi
done
