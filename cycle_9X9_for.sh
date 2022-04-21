#!/bin/bash
# Author      : Kung
# Build       : 2022-04-21 19:50
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

for num1 in `seq 9`
do
 for num2 in `seq 9`
  do
	if [ $num1 -ge $num2 ]
	  then
		if(((num1*num2)>9))
		 then
		   echo -en "${num1}X${num2}=$((num1*num2)) "
	  	
	         else
		   echo -en "${num1}X${num2}=$((num1*num2))  "
		fi
	fi	

  done
echo " "
done
 
