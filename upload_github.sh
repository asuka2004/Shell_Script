#!/bin/bash
#Author: Kung
#Subject: Auto Git	
	git add * 
	git commit -m $(date +%Y/%m/%d)
	git push -u origin master
