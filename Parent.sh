#!/bin/bash
# Author      : Kung
# Build       : 2022-04-17 14:58
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
    
A=B
echo "PID for Parent.sh before exec/source/fork:$$"
export A
echo "Parent.sh: \$A is $A"
    	
case $1 in
 exec)
	echo "using exec…"
        exec ./Child.sh ;;
 source)
        echo "using source…"
          . ./Child.sh ;;
 *)
        echo "using fork by default…"
            ./Child.sh ;;
esac
  	
echo "PID for Parent.sh after exec/source/fork:$$"
echo "Parent.sh: \$A is $A"
