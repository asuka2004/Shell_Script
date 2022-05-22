#!/bin/bash
# Author      : Kung
# Build       : 2022-05-22 16:18
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


useradd rsync -s /sbin/nologin -M
mkdir -p /backup
chown -R rsync.rsync /backup
echo "rsync_backup:P@ssw0rd">/etc/rsync.password
chmod 600 /etc/rsync.password
systemctl start rsyncd
systemctl enable rsyncd
systemctl status rsyncd


