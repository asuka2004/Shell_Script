#!/bin/bash
# **************************************************
# Description  : Batch to add/del  user 
# Build        : 2022-04-11 22:32
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
# ************************************************ 
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions

Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}


User="std"
Password_File="/root/github/passwd.txt"

for num in `seq -w 05`
do
 	Password="`openssl rand -base64 10 |md5sum|cut -c 3-8`"
 	useradd $User$num &>/dev/null 
 	echo " ${Password}|passwd --stdin $user$num &>/dev/null"  
	echo -e "User:$User$num\tPassword:$Password">>${Password_File}
 		if [ $? -eq 0 ]
  	 	 then
			action "$User$num add new account" /bin/true
 		else
			action "$User$num fail new account" /bin/false
 		fi

done

sleep 5
echo "..................................................................."

for n in {01..05} 
do 
	userdel -r std$n 
		if [ $? -eq 0 ]
	 	 then
			action "$User$n success to del account" /bin/true
		else
			action "$User$n fail to del account" /bin/false
		fi
done
