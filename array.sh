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

array=(1 2 3 4 5 6 7)
for ((i=0;i<${#arr[*]};i++))
do
 	if [ ${array[*]} -eq 4 ]
	 then
		echo "${array[$i]}"
 	fi
done
