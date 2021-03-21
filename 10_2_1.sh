#!/bin/bash
while [ 1 ]
do
 uptime >>/root/homework/uptime.log
 usleep 200000
done
