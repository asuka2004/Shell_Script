#!/bin/sh
# **************************************************
# Description  : monitor nginx 
# Build        : 2022-03-25 23:14
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

if [ `netstat -ntulp|grep nginx|wc -l` -gt 0 ];then
	echo  "Web is running"  
else
	echo "Web will reboot"
	/usr/bin/systemctl restart nginx
fi
