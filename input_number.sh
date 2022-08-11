#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 21:04
# Version     : V1.0
# Description :            
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

print_usage(){
	printf "Please enter integer!!! Thks\n"
	exit 1
}

read -p "Please input first number:" firstnum
if [ -n "`echo $firstnum|sed 's/[0-9]//g'`" ]
 then
	print_usage	
fi

read -p "Please input the operators:" operators
if [ "${operators}" != "+" ]&&[ "${operators}" != "-" ]&&[ "${operators}" != "*" ]&&[ "${operators}" != "/" ]
 then
	echo "Please use {+|-|*|/}"
	exit 2
fi

read -p "Please input second number:" secondnum
if [ -n "`echo $secondnum|sed 's/[0-9]//g'`" ]
 then
	print_usage
fi
echo "${firstnum}${operators}${secondnum}=$((${firstnum}${operators}${secondnum}))"

