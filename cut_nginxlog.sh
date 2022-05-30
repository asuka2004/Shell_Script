#!/bin/bash
# Author      : Kung
# Build       : 2022-05-28 19:46
# Version     : V1.0
# Description : Cut Nginx log            
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

Dateformat=`date +%Y%m%d -d -1day`
Basedir="/usr/local/nginx"
Nginxlog="$Basedir/logs"
Logname="access_www"

[ -d $Nginxlog ] && cd $Nginxlog || exit 1
[ -f ${Logname}.log ] || exit 1
mv ${Logname}.log ${DateFormat}_${Logname}.log
$Basedir/sbin/nginx -s reload



