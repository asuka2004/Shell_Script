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

array=(a b c d e f)
for ((i=0;i<${#arr[*]};i++))
do
 if [ ${#array[$i]} -lt 7 ]
	then
		echo "${array[$i]}"
 fi
done
