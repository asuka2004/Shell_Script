#!/bin/bash

trapper(){
	trap ':' INT EXIT TSTP TERM HUP
}

main(){
	while :
	do
		trapper
		clear
		cat <<end 
		1) 192.168.88.26	
		2) 192.168.88.27
		
end
		read -p "pls input a num" num
		case "$num" in
		1)
		echo 'login in 192.168.88.26'
		ssh 192.168.88.26
		;;	
		2)
		echo 'login in 192.168.88.51'
		ssh 192.168.88.51
		;;
		*)
		echo 'Please select 1 or 2'
		esac
		
	done
}
main
