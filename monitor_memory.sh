#!/bin/sh
# **************************************************
# Description  : monitor memory 
# Build        : 2022-03-25 23:03
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

Memory=`free -m|awk 'NR==2 {print $NF}'`
Alarm="Warining!!! Current time is `date +%F-%T` and Memory leave over $Memory"
if [ $Memory -lt 3500 ]
 then
	echo $Alarm>> /root/message.txt
	mail -s "`date +%F-%T` $Alarm" root@localhost</root/message.txt

fi
 
