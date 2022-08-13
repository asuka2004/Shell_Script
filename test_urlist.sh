#!/bin/bash
# Author      : Kung
# Build       : 2022-04-13 20:04
# Version     : V1.0
# Description : Monitor Web list           
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

Url_Count=0
Url_List=(
www.google.com
www.kung.roc
www.yahoo.com.tw
www.sina.com.tw
www.ithome.com.tw
)
function Url_Check(){
	for((i=0;i<${#Url_List[*]};i++))
	do
		wget -o /dev/null -T 3 --tries=1 --spider ${Url_List[$i]}>/dev/null 2>&1
		if [ $? -eq 0 ]
		 then
			action "${Url_List[$i]}" /bin/true
		else
			action "${Url_List[$i]}" /bin/false
		fi		
	done
	((Url_Count++))
}

function main(){
	while true
	do
		Url_Check
		echo "Please wait me five second!!! The count is $Url_Count time "
		sleep 5  
	done
}
main $* 
