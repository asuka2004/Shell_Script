#!/bin/sh
# **************************************************
# Description  : Whether url list is heathy or not  
# Build        : 2022-03-24 23:26
# Author       : Kung
# System       : CentOS 7.6 
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

url_count=0
url_list=(
www.google.com
www.kung.roc
www.yahoo.com.tw
www.sina.com.tw
www.pchome.com.tw
www.ithome.com.tw
)
function url_check(){
	for((i=0;i<${#url_list[*]};i++  ))
	do
		wget -o /dev/null -T 3 --tries=1 --spider ${url_list[$i]}>/dev/null 2>&1
		if [ $? -eq 0 ];then
			action "${url_list[$i]}" /bin/true
		else
			action "${url_list[$i]}" /bin/false
		fi		
	done
	((url_count++))
}

function main(){
	while true
	do
		url_check
		echo "Please wait me five second!!! The count is $url_count time "
		sleep 5  
	done
}
main 
