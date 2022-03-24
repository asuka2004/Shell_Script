#!/bin/sh
# **************************************************
# Description  : Whether url is heathy or not 
# Build        : 2022-03-24 23:37
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

checkurl(){
timeout=10
fails=0
success=0

while true
 do
 wget --timeout=$timeout --tries=5 http://www.gss.sscom -q -O /dev/null
 if [ $? -ne 0 ]
  then
        ((fails=fails+1))
  else
	((success=success+1))
 fi
 
 if [ $fails -ge 1 ]
  then
	critical="Waining!!!!websit is going down"
	echo $critical|tee|mail -s "$critical" root@localhost
	exit 2
 fi

 if [ $success -ge 2 ]
  then
	echo "success"
	exit 0
 fi

 done
}
checkurl
