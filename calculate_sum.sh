#!/bin/sh
# **************************************************
# Description  : 
# Build        : 2022-03-24 23:56
# Author       : Kung
# System       : 
# Version      : 
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

for ((i=1;i<=15;i++))
do
	((sum=sum+i))	
done

echo $sum
