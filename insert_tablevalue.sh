#!/bin/sh
# **************************************************
# Description  : insert table into database on mysql 5.6
# Build        : 2022-03-25 23:27
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

echo "请输入字段servnumber的值："
read serber
echo "请输入创建sql语句的数量："
read number
# char=`head /dev/urandom | tr -dc 0-9 | head -c 11`
for (( i=0;i<$number;i++ ))
do
pass=`head /dev/urandom | tr -dc a-z | head -c 8`
let serber=serber+1
echo "insert into test(id,username,servnumber,password,createtime)
values('$i','user${i}','${serber}','$pass',now());" >>sql.txt
done
