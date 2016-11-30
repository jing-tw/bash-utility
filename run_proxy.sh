#!/bin/bash

. ./proxy_utility.sh
function run_proxy(){
	local c
	printf "== System Setup ==\n\
	0) No Proxy\n\
	1) Proxy Setup\n"

	read -p "Enter your choice " c
	case $c in
		0)	no_proxy ;;
		1)	all_proxy ;;
		*)	
			echo "Invalid Input"
			pause
	esac
}

run_proxy
