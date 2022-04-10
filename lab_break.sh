#!/bin/sh
# **************************************************
# Description  : study "break continue exit return" 
# Build        : 2022-03-25 21:43
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

if [ $# -ne 1 ]
 then
	echo "Please input {break|continue|exit|return}"
	exit 1
fi

test(){
 for ((i=0;i<=5;i++))
 do
	if [ $i -eq 3 ];then
		$*	
	fi
	echo $i	
 done
 echo "I am in func"
}
test $*
 
