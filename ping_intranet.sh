#!/bin/sh
# **************************************************
# Description  : ping  ip
# Build        : 2022-03-25 23:04
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

CMD="ping -w 2 -c 2"
IP="192.168.88."
for n in `seq 10` 
do
	$CMD $IP$n &>/dev/null
	if [ $? -eq 0 ];then
		echo "$IP$n is OK"
	fi

done
