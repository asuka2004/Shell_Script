#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 19:51
# Version     : V1.0
# Description : Create a lot of data            
# System      : CentOS 7.6 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

echo "Please input servnumber: "
read serber
echo "Please input sql "
read number
# char=`head /dev/urandom | tr -dc 0-9 | head -c 11`
for (( i=0;i<$number;i++ ))
do
	pass=`head /dev/urandom | tr -dc a-z | head -c 8`
  	((serber=serber+1))
	echo "insert into test(id,username,servnumber,password,createtime) values('$i','user${i}','${serber}','$pass',now());" >>sql.txt
done
