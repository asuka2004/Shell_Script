#!/bin/bash
# **************************************************
# Description  : 
# Build        : 2022-04-11 22:36
# Author       : Kung
# System       : 
# Version      : 
# ************************************************ 
export LANG=C
export PATH=$PATH
. /etc/init.d/functions
script_path=/root/github
log_path=/root/tmp
	git add --all 
	git commit -m $(date +%Y/%m/%d)
	git push -u origin master
