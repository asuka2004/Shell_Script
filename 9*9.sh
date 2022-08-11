#!/bin/bash


for n1 in `seq 9`
do
	for n2 in `seq 9`
	do
		echo -en "${n1}X${n2}=$((n1*n2))"	
	
	done
	echo " "
done
