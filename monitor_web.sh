#!/bin/bash
# Author      : Kung
# Build       : 2022-04-14 23:40
# Version     : V1.0
# Description : Check Web is not OK!!           
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

Check_Url(){
timeout=10
Fails=0
Success=0

while true
 	do
		wget --timeout=$timeout --tries=5 http://www.google.com -q -O /dev/null
 		if [ $? -ne 0 ]
  	 	then
        		((Fails=Fails+1))
 		else
			((Success=Success+1))
 		fi
 
 		if [ $Fails -ge 2 ]
  	 	then
			Critical="Waining!!!!websit is going down"
			echo $Critical | tee | mail -s "$Critical" root@localhost
			exit 2
 		fi

 		if [ $Success -ge 2 ]
  	 	then
			echo "Success"
			exit 0
 		fi

 	done
}
Check_Url

