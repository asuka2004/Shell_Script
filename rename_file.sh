#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 21:05
# Version     : V1.0
# Description :            
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

NewFile=_asuka.html
Dirname="/root"
cd $Dirname||exit 1
for n in `ls`
do
	name=$(echo $n|awk -F '_' '{print $1}' )
	mv $n ${name}${NewFile}
done
