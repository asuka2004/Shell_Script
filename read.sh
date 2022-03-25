#!/bin/sh
# **************************************************
# Description  : study read
# Build        : 2022-03-25 22:57
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions

read -p "pls input your name:" name
read -p "pls input your password:" pass
echo -n "Your name is $name and Password is $pass"
 
