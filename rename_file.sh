#!/bin/sh
# **************************************************
# Description  : rename a lot of file 
# Build        : 2022-03-25 23:19
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

NewFile=_asuka.html
Dirname="/root"
cd $Dirname||exit 1
for n in `ls`
do
	name=$(echo $n|awk -F '_' '{print $1}' )
	mv $n ${name}${NewFile}
done
