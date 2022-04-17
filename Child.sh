#!/bin/bash
# Author      : Kung
# Build       : 2022-04-17 15:04
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
    
    echo "PID for Child.sh: $$"
    echo "Child.sh get \$A=$A from Parent.sh"
    A=C
    export A
    echo "Child.sh: \$A is $A"
