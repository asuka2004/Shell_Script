#!/bin/bash

array=(1 2 3 4 5)

for((i=0;i<${#array[*]};i++))
do
	echo ${array[i]}
done


for n in ${array[*]}
do
	echo $n
done


i=0
while ((i<${#array[*]}))
do
	echo ${array[i]}
	((i++))
done
