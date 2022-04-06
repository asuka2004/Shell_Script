#!/bin/sh
# **************************************************
# Description  : change log 
# Build        : 2022-03-25 23:30
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions
base_path='/usr/local/nginx/logs'
log_path=$(date -d yesterday +"%Y%m")
day=$(date -d yesterday +"%d")
mkdir -p $base_path/$log_path
mv $base_path/access.log $base_path/$log_path/access_$day.log
#echo $base_path/$log_path/access_$day.log
kill -USR1 `cat /usr/local/nginx/logs/nginx.pid`

