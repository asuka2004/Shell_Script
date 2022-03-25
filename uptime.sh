#!/bin/sh
# **************************************************
# Description  : study uptime
# Build        : 2022-03-25 23:15
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

while [ 1 ]
do
 uptime >>/root/uptime.log
 usleep 5 
done
