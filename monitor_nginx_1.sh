#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 20:59
# Version     : V1.0
# Description : Use script to choice           
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

path=/usr/local/nginx/sbin/
pid=/usr/local/nginx/logs/nginx.pid
RETVAL=0

start(){
	if [ `netstat -ntulp|grep nginx|wc -l` -eq 0 ];then 
		$path/nginx
		RETVAL=$?		
				
		if [ $RETVAL -eq 0 ];then
			action "NGINX is starting" /bin/true
			return $RETVAL
		else
			action "NGINX fail to start " /bin/false
			return $RETVAL
		fi
	else
		echo "NGINX is normal,nothing to do"
		return 0

	fi
}


stop(){
	if [ `netstat -ntulp| grep nginx| wc -l` -gt 0 ];then
		$path/nginx -s stop
		RETVAL=$?
		
		if [ $RETVAL -eq 0 ];then
			action "NGINX is stopping" /bin/true
			return $RETVAL
		else
			action "NGINX fail to stop" /bin/false
			return $RETVAL
		fi

	else
		echo "NGINX stop always"
		return $RETVAL
	fi
}


case "$1" in
	start)
		start
		RETVAL=$?
	;;
	stop)
		stop
		RETVAL=$?
	;;
	restart)
		stop
		sleep 1
		start
		RETVAL=$?
	;;
	*)
		echo $"USAGE: $0 {start|stop|restart}"
		exit 1

esac
exit $RETVAL


