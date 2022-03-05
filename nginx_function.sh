#!/bin/bash
path=/usr/local/nginx/sbin/
pid=/usr/local/nginx/logs/nginx.pid
RETVAL=0
. /etc/init.d/functions

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












