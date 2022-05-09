#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 21:00
# Version     : V1.0
# Description : Random file
# System      : CentOS 7.6

export PS4='++ ${LINENO}'
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

Path=/root/test
[ -d "$PATH" ]|| mkdir -p $Path

for n in `seq 10`
do
	random=$(openssl rand -base64 40| sed 's#[^a-z]##g'|cut -c 1-10)
	touch $Path/${random}_.html
done
 
