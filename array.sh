#!/bin/sh
# **************************************************
# Description  : study array
# Build        : 2022-03-25 22:52
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

array=( i am gilson not tony kung )
for ((i=0;i<${#array[*]};i++))
do
 	if [ ${#array[$i]} -lt 3 ]
	 then
		echo "${array[$i]}"
 	fi
done
