#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 20:58
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

script_path=/root/github
log_path=/root/tmp
	git add --all 
	git commit -m $(date +%Y-%m-%d-%R)
	git push -u origin master
