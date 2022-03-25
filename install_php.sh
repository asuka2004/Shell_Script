#!/bin/sh
# **************************************************
# Description  : install php 
# Build        : 2022-03-25 23:26
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

path=/root/gittest
[ ! -d "$path" ]&& mkdir -p $path 

cat<<END

 1.[install lamp]
 2.[install lnmp]
 3.[exit]
Please input the num you want:
END

read num
expr $num + 1 &>/dev/null
[ $? -ne 0 ]&&{
	echo "the num you input must be {1|2|3}"
	exit 1
}

[ $num -eq 1 ]&&{
	echo "Start installing lamp"
	sleep 2;
	
	[ -x "$path/lamp.sh" ]||{
	echo "$path/lamp.sh does not exist or can not be exec"
	exit 1
	}
	$path/lamp.sh
	exit $?
}


[ $num -eq 2 ]&&{
	echo "Starting install lnmp"
	sleep 2;

	[ -x "$path/lnmp.sh"]||{
	echo "$path/lnmp.sh does not exist or can not be exec"
	exit 1
	}
	$path/lnmp.sh
	exit $?
}

[ $num -eq 3 ]&&{
	echo bye
	exit 3

}





