#!/bin/bash

PATH="/root/homework/*"


while true

 
do
	git add $PATH
	git commit -m "date +%m/%d-%H:%M"
	git push -u origin main
done
