#!/bin/bash
# **************************************************
# Description  : batch to add  user 
# Build        : 2022-04-11 22:32
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
# ************************************************ 
export LANG=C
export PATH=$PATH
. /etc/init.d/functions
script_path=/root/github
log_path=/root/tmp
user="student"
passfile="/root/github/userpasswd.log"

for num in `seq -w 05 `
do
 pass="`openssl rand -base64 10 |md5sum|cut -c 3-8`"
 useradd $user$num &>/dev/null && echo "$pass|passwd --stdin $user$num &>/dev/null" && echo -e "user:$user$num\tpasswd:$pass">>$passfile
 if [ $? -eq 0 ]
  then
	action "$user$num add new account" /bin/true
 else
	action "$user$num fail new account" /bin/false
 fi

done
#subject: del user
#del account
# for n in student{01..05} 
#do 
#	userdel -r $n 
#done
