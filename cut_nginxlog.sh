#!/bin/bash
# Author      : Kung
# Build       : 2022-05-28 19:46
# Version     : V1.0
# Description : Cut Nginx log every day            
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

DataFormat=`date +%Y%m%d -d -1day`
Basedir="/usr/local/nginx"
Nginxlog="$Basedir/logs"

[ -d $Nginxlog ] && cd $Nginxlog || exit 1
[ -f access.log ] || exit 1
mv access.log access_${DataFormat}.log
$Basedir/sbin/nginx -s reload



