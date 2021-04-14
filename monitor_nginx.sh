#!/bin/bash
# Author:   Kung
# Function: monitor nginx

if [ `netstat -ntulp|grep httpd|wc -l` -gt 0 ];then
	echo  "Web is running"  
else
	echo "web will reboot"
	/usr/bin/systemctl restart httpd
fi
