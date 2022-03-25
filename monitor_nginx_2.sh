#!/bin/sh
# **************************************************
# Description  : test lvs is normal or not
# Build        : 2022-03-25 23:24
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

counter=$(ps -C nginx --no-heading|wc -l)
if [ "${counter}" -eq "0" ]; then
	/usr/bin/systemctl stop keepalived 
	echo 'NGINX Server is dead..Please fix this Nginx'
else
	/usr/bin/systemctl start keepalived
fi
