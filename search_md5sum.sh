#!/bin/sh
# **************************************************
# Description  :  
# Build        : 2022-03-24 23:54
# Author       : Kung
# System       : 
# Version      : 
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

for n in {0..10}
do
	echo "`echo $n|md5sum` $n" >>/root/github/md5sum.log
done


md5search="fdd96b0a2ea29515"
while read line
do
	if [ `echo $line|grep "$md5search"|wc -l` -eq 1 ];then
	echo $line
	break
	fi
done</root/github/md5sum.log

