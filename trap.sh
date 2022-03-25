#!/bin/sh
# **************************************************
# Description  : study trap 
# Build        : 2022-03-25 22:56
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

trap "find /tmp -type f -name "_*" |xargs rm -rf && exit" INT
while true
do
	touch /tmp/_$(date +F-%H-%M-%S)
	sleep
	ls -l /tmp/*
done
 
