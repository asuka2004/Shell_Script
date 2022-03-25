#!/bin/sh
# **************************************************
# Description  : resist ddos
# Build        : 2022-03-25 23:05
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

file=$1
while true
do
 awk '{print $1}' $1 | grep -v "^$"|sort|uniq -c >/root/tmp.log
 exec</root/tmp.log
 while read line
  do
	ip=`echo $line|awk '{print $2}'`
	count=`echo $line|awk '{print $1}'`
	if [ $count -gt 30 ];then
	firewall-cmd --add-rich-rule "rule family="ipv4" source address="$ip" port port="80" protocol="tcp"  reject"
	echo "$line is dropped">>/root/droplist_$(date +F%).log
	fi
  done
  sleep 20
done
