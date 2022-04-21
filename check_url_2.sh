#!/bin/sh
# **************************************************
# Description  : 
# Build        : 2022-04-07 21:50
# Author       : Kung
# System       : 
# Version      : 
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

if [ $# -ne 1 ]
 then
	echo $"Usage $0 url"
	exit 1
fi

while true
do
	if [ `curl -o /dev/null --connect-timeout 5 -s -w "%{http_code}" $1| egrep -w "200|301|302"|wc -l` -ne 1 ]
	 then
		action "Web $1 fail" /bin/false
	else
		action "Web $1 is OK" /bin/true
	fi
	sleep 5
done

