#!/bin/sh
# **************************************************
# Description  : cal apache log  sum
# Build        : 2022-03-25 23:19
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

sum=0
exec<$1
while read line
do
 size=`echo $line |awk '{print $10}'`
 expr $size + 1 &>/dev/null
 if [ $? -ne 0 ]
  then
	continue
 fi
 ((sum=sum+$size))
done
echo "Total: `echo $((${sum}/1024)) KB`"
