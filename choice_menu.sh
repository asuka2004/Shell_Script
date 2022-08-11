#!/bin/bash
# Author      : Kung
# Build       : 2022-07-30 22:00
# Version     : V1.0
# Description : Choice menu            
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

function usage(){
	echo "Usage: $0 {1|2|3|4}"
	exit 1
}

function menu(){
	cat << END
	1.apple
	2.pear
	3.banana
END
}

function choice(){
	read -p "Please input your choice:" fruit 
	case "$fruit" in
	1)
		echo -e "apple";;
	2)
		echo -e "pear";;
	3)
		echo -e "banana";;	
	*)
		usage;;
	esac 
}
function main(){
	menu
	choice
}
main $*


