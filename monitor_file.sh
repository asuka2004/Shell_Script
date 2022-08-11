#!/bin/bash
# Author      : Kung
# Build       : 2022-05-07 23:42
# Version     : V1.0
# Description : Monitor Web file           
# System      : CentOS 7.9 
			       
export PS4='++ ${LINENO}'  
export LANG=C
export PATH=$PATH
[ -f /etc/init.d/functions ] && . /etc/init.d/functions
Script_Path=/root/project/github
[ ! -d ${Script_Path} ] && mkdir -p ${Script_Path}
Log_Path=/root/tmp
[ ! -d ${Log_Path} ] && mkdir -p ${Log_Path}

RETVAL=0
CHECK_DIR=/var/www/html
[ -e $CHECK_DIR ]||exit 1

CONTEXT="/root/tmp/context.db.ori"
COUNT="/root/tmp/count.db.ori"
ERROR_LOG="/root/tmp/err.log"

[ -e $COUNT ]|| exit 1

md5sum -c --quiet  /tmp/context.db.ori &>>$ERROR_LOG
RETVAL=$?

find $CHECK_DIR -type f >/tmp/count_current.db.ori
diff /tmp/count* &>>$ERROR_LOG

if [ $RETVAL -ne 0 -o `diff /tmp/count*|wc -l` -ne 0 ] 
 then
	mail -s "`uname -n` $(date +%F) err asuka.2004@gmail.com<$ERROR_LOG"
 else
	echo "Site is normal"| mail -s "`uname -n` $(date +%F) is ok" asuka.2004@gmail.com
fi
