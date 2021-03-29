#!/bin/bash
#author: Kung
#Subject: auto git	
	git add * 
	git commit -m $(date +%m/%d-%H:%M)
	git push -u origin main
