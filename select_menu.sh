#!/bin/bash
# **************************************************
# Description  : Install menu
# Build        : 2022-04-10 10:35
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
# ************************************************ 
export LANG=C
export PATH=$PATH
. /etc/init.d/functions
script_path=/root/github
log_path=/root/tmp

[ ! -d "$script_path" ] && mkdir $script_path -p
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

	if [ ! -x "$script_path/${1}.sh" ]
	 then
		echo "$script_path/${1}.sh do not exist or cat not exec"
		return 1
	else
		$script_path/${1}.sh
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
