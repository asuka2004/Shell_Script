#!/bin/sh
# **************************************************
# Description  : Push script to Github 
# Build        : 2022-03-24 23:08
# Author       : Kung
# System       : 
# Version      : 
#              :     
# *************************************************
export PATH=$PATH
. /etc/init.d/functions
	git add * 
	git commit -m $(date +%Y/%m/%d)
	git push -u origin master
