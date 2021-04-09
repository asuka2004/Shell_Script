#!/bin/bash

trap "find /tmp -type f -name "kung_*" |xargs rm -rf && exit" INT
while true
do
	touch /tmp/kung_$(date +F-%H-%M-%S)
	sleep
	ls -l /tmp/kung*
done
#author:kung
i am kung
