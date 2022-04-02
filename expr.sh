#!/bin/bash

if expr "$1" : ".*\.pub" &>/dev/null
 then
	echo "use $1"
else
	echo "pls use .pub file"
fi
