#!/bin/sh
# **************************************************
# Description  : Enter number and + - * %   
# Build        : 2022-04-02 11:14
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

print_usage(){
	printf "Please enter an integer!!! Thks\n"
	exit 1
}

read -p "Please input first number:" firstnum
if [ -n "`echo $firstnum|sed 's/[0-9]//g'`" ]
 then
	print_usage	
fi

read -p "Please input the operators:" operators
if [ "${operators}" != "+" ]&&[ "${operators}" != "-" ]&&[ "${operators}" != "*" ]&&[ "${operators}" != "/" ]
 then
	echo "Please use {+|-|*|/}"
	exit 2
fi

read -p "Please input second number:" secondnum
if [ -n "`echo $secondnum|sed 's/[0-9]//g'`" ]
 then
	print_usage
fi
echo "${firstnum}${operators}${secondnum}=$((${firstnum}${operators}${secondnum}))"


 
