#!/bin/bash

Freememory=`free -m|awk 'NR==2 {print $NF}'`
Chars="Warining!!! Current time is `date +%F-%T` and Memory leave over $Freememory"
if [ $Freememory -lt 1500 ]
 then
	echo $Chars>> /root/message.txt
	mail -s "`date +%F-%T` $Chars" root@localhost</root/message.txt

fi
#author:kung
