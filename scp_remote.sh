#!/bin/sh
# **************************************************
# Description  : study cp file to remote ip 
# Build        : 2022-03-25 23:17
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions
if [ $# -ne 2 ];then
	echo $"Usage:$0 file dir"
	exit
fi
file=$1
dir=$2

for n in 101 102 
do
	expect scp_remote.exp $file 192.168.88.$n $dir
done
