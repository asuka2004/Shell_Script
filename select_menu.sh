#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 21:06
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
			       

function Usage(){
	echo "Usage: $0 argv"
	return 1
}

function Install_Service(){
	if [ $# -ne 1 ]
	 then
		Usage
	fi
	local retval=0
	echo "Ready for installation ${1}"
	sleep 2

	if [ ! -x "$Script_Path/${1}.sh" ]
	 then
		echo "$Script_Path/${1}.sh do not exist or cat not exec"
		return 1
	else
		$Script_Path/${1}.sh
		return $retval
	fi
}

function main(){
	PS3="Please select a num from menu:"
	select var in "Install lamp" "Install lnmp" "exit"
	do
		case "$var" in
			"Install lamp")
				Install_Service lamp
				retval=$?
				;;
			"Install lnmp")
				Install_Service lnmp
				retval=$?
				;;
			exit)
				echo bye
				return 3
				;;
			*)
				echo "Please input these menu {1|2|3}"
				echo "Input error"

		esac	
	done
exit $ retval
}
main
