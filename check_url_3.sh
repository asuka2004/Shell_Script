#!/bin/sh
# **************************************************
# Description  : test web is normal or not 
# Build        : 2022-03-25 23:20
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

if [ $# -ne 1 ]
 then
 	echo $"usage $0 url"
 	exit 1
fi

while true
do
 if [ `curl -o /dev/null --connect-timeout 5 -s -w "%{http_code}" $1|egrep -w "200|301|302"|wc -l` -ne 1 ]
	then
	 action "$1 is error" /bin/false
 else
	 action "$1 is ok" /bin/true
 fi
 sleep 5
done
