#!/bin/sh
# **************************************************
# Description  : Random output html
# Build        : 2022-03-25 21:42
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

Path=/root/test
[ -d "$PATH" ]|| mkdir -p $Path

for n in `seq 10`
do
	random=$(openssl rand -base64 40| sed 's#[^a-z]##g'|cut -c 1-10)
	touch $Path/${random}_.html
done
 
