#!/bin/bash
. /etc/init.d/functions
FILE_PATH=/root/gittest/openvpn.conf
[ ! -f $FILE_PATH ]&& touch $FILE_PATH

usage(){
 	USAGE:`basename $0` {-add|-del|-search} username
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
	*)
	usage
	exit
	;;
esac
