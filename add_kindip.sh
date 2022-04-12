#!/bin/bash
# **************************************************
# Description  : Batch add/del Network IP Address 
# Build        : 2022-04-12 21:28
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
# ************************************************ 
export PS4='+${LINENO} '
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions

script_path=/root/github
[ ! -d ${script_path} ] && mkdir -p ${script_path}
log_path=/root/tmp
[ ! -d ${log_path} ] && mkdir -p ${log_path}

RETVAL=0
add(){
	for ip in {1..5}
	do
		if [ $ip -eq 10 ]
		 then
		continue
		fi
		
	ip addr add 192.168.88.$ip/24 dev eth0 label eth0:$ip &>/dev/null
	RETVAL=$?

		if [ $RETVAL -eq 0 ]
		 then
			action "Success to add 192.168.88.$ip" /bin/true
		else
			action "Fail to add 192.168.88.$ip" /bin/false
		fi
	done
	return $RETVAL
}

del(){
	for ip in {5..1}
	do
		if [ $ip -eq 10 ]
		 then
			continue
		fi

	ifconfig eth0:$ip down &>/dev/null
	RETVAL=$?

		if [ $RETVAL -eq 0 ]
		 then
			action "Success to del 192.168.88.$ip" /bin/true
		else
			action "Fail to del 192.168.88.$ip" /bin/false
		fi
	done
}

case "$1" in
	start)
		add
		RETVAL=$?
		;;
	stop)
		del
		RETVAL=$?
		;;
	restart)
		del
		sleep 2
		add
		RETVAL=$?
		;;
	*)
		printf "Usage:$0 {start|stop|restart}\n"

esac
exit $RETVAL

