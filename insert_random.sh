#!/bin/bash
# Author      : Kung
# Build       : 2022-05-05 23:22
# Version     : V1.0
# Description :            
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}


#!/bin/bash
echo "请输入字段servnumber的值:"
read serber
echo "请输入创建sql语句的数量:"
read number
# char=`head /dev/urandom | tr -dc 0-9 | head -c 11`
for (( i=0;i<$number;i++ ))
do
pass=`head /dev/urandom | tr -dc a-z | head -c 8`
let serber=serber+1
echo "insert into test(id,username,servnumber,password,createtime)
values('$i','user${i}','${serber}','$pass',now());" >>sql.txt
done
