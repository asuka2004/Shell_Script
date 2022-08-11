#!/bin/bash
# Author      : Kung
# Build       : 2022-04-20 21:48
# Version     : V1.0
# Description : Jump Server           
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

trapper(){
	trap ':' INT EXIT TSTP TERM HUP
}

main(){
	while :
	do
		trapper
		clear
		cat <<end 
		1) 192.168.88.26	
		2) 192.168.88.27
		
end
		read -p "Please input a number:" num
		case "$num" in
		1)
		echo 'login in 192.168.88.26'
		ssh 192.168.88.26
		;;	
		2)
		echo 'login in 192.168.88.51'
		ssh 192.168.88.51
		;;
		*)
		echo 'Please select 1 or 2'
		esac
		
	done
}
main $*
