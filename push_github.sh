#!/bin/bash
# **************************************************
# Description  : push to github 
# Build        : 2022-04-11 22:36
# Author       : Kung
# System       : CentOS 7.6
# Version      : 1.1
# ************************************************ 
export LANG=C
export PATH=$PATH
. /etc/init.d/functions
script_path=/root/github
log_path=/root/tmp
	git add --all 
	git commit -m $(date +%Y/%m/%d/%R)
	git push -u origin master
