#!/bin/sh
# **************************************************
# Description  : Add/del ip to network card 
# Build        : 2022-03-24 23:43
# Author       : Kung
# System       : CentOS 7.6 
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

[ -f /etc/init.d/functions ]&& . /etc/init.d/functions
RETVAL=0
add(){
	for ip in {1..16}
	do
		if [ $ip -eq 10 ];then
		continue
		fi
		
		ip addr add 192.168.88.$ip/24 dev eth0 label eth0:$ip &>/dev/null
		RETVAL=$?

		if [ $RETVAL -eq 0 ];then
			action "add $ip" /bin/true
		else
			action "add $ip" /bin/false
		fi
	done
	return $RETVAL
}


del(){
	for ip in {16..1}
	do
		if [ $ip -eq 10 ];then
			continue
		fi

		ifconfig eth0:$ip down &>/dev/null
		RETVAL=$?

		if [ $RETVAL -eq 0 ];then
			action "del $ip" /bin/true
		else
			action "del $ip" /bin/false
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

