#!/bin/sh
# **************************************************
# Description  : protect file 
# Build        : 2022-03-25 23:12
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

RETVAL=0
CHECK_DIR=/var/www
[ -e $CHECK_DIR ]||exit 1

CONTEXT="/tmp/context.db.ori"
COUNT="/tmp/count.db.ori"
ERROR_LOG="/tmp/err.log"

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
