#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 08:51
# Version     : V1.0 First
# Description : Add/Del VPN User list           
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

usage(){
	echo "USAGE: $0 {-add|-del} username"
} 

if [ $UID -ne 0 ];then
	echo "You are not supper user,Please use root"
	exit 1;
fi

if [ $# -ne 2 ];then
	usage
	exit 2;
fi

case "$1" in
	-add)
	shift
	if grep "^$1$" ${FILE_PATH} >/dev/null 2>&1
		then
			action $"vpnuser,$1 is exist" /bin/false
			exit
	else
		chattr -i ${FILE_PATH}
		/bin/cp ${FILE_PATH} ${FILE_PATH}.$(date +%F%T)
		echo "$1" >> ${FILE_PATH}
		[ $? -eq 0 ]&&action $"add $1" /bin/true
		chattr +i ${FILE_PATH}
	fi
	;;

	-del)
	shift
	if [ `grep "\b$1\b" ${FILE_PATH}|wc -l` -lt 1 ];then
		action $"vpnuser,$1 is not exist" /bin/false
		exit 
	else
		chattr -i ${FILE_PATH}
		/bin/cp ${FILE_PATH} ${FILE_PATH}.$(date +%F%T)
		sed -i "/^${1}$/d" ${FILE_PATH}
		[ $? -eq 0 ]&& action $"del $1" /bin/true
		chattr +i ${FILE_PATH}
		exit
	fi
	;;

	-search)
	shift
	if [ `grep -w "$1" ${FILE_PATH}|wc -l` -lt 1 ]
	 then
		echo $"$1 not exist"
		exit
	else
		echo $"$1 exist"
		exit
	fi
	;;

	*)
	usage
	exit
	;;
esac
