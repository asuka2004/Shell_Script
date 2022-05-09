#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 08:51
# Version     : V1.0
# Description : Batch Add/Del VPN User list
# System      : CentOS 7.6

export PS4='++ ${LINENO}'
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}
File_Path=/root/github/vpn.txt
[ ! -f ${File_Path} ] && touch ${File_Path}

usage(){
	echo "USAGE: $0 {-add|-del|-search} username"
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
	if grep "$1" ${File_Path} >/dev/null 2>&1
		then
			action $"VPN User $1 already exists" /bin/false
			exit
	else
		chattr -i ${File_Path}
		cp ${File_Path} ${File_Path}_$(date +%F%T).txt
		echo "$1" >> ${File_Path}
		[ $? -eq 0 ] && action $"Success to add VPN User $1" /bin/true
		chattr +i ${File_Path}
		exit
	fi
	;;

	-del)
	shift
	if [ `grep "$1" ${File_Path}|wc -l` -lt 1 ]
	 then
		action $"Not find VPN User $1" /bin/false
		exit 
	else
		chattr -i ${File_Path}
		cp ${File_Path} ${File_Path}_$(date +%F%T)
		sed -i "/^${1}$/d" ${File_Path}
		[ $? -eq 0 ] && action $"Success to del VPN User $1" /bin/true
		chattr +i ${File_Path}
		exit
	fi
	;;

	-search)
	shift
	if [ `grep -w "$1" ${File_Path}|wc -l` -lt 1 ]
	 then
		echo $"Not find VPN User $1"
		exit
	else
		echo $"VPN User $1 already exists"
		exit
	fi
	;;

	*)
	usage
	exit
	;;
esac
