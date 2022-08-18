#!/bin/bash
# Author      : Kung
# Build       : 2022-05-05 23:22
# Version     : V1.0
# Description : Random lot of information to insert mysql5.6           
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

echo "Please input server number:"
read server
echo "Please input sql number:"
read number

for (( i=0;i<$number;i++ ))
do
pass=`head /dev/urandom | tr -dc a-z | head -c 8`
let server=server+1
echo "insert into test(id,username,servnumber,password,createtime)
values('$i','user${i}','${server}','$pass',now());" >>/root/tmp/sql.txt
done
