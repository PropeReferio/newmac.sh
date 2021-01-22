#! /bin/bash

#The block below creates a random, valid MAC
x=$(openssl rand -hex 3)
#List of valid OUI's from manufacturers: http://standards-oui.ieee.org/oui/oui.txt
declare -a oui=("d8:97:90" "98:e7:43" "88:7e:25" "e0:eb:62" "08:9c:86" "cc:88:26" "a0:91:a2"
"4c:17:44" "30:ea:26" "80:da:13")
length=${#oui[@]}
index=$(($RANDOM % $length))
mac="${oui[$index]}:${x:0:2}:${x:2:2}:${x:4:2}"

function show_usage(){
	printf "Usage: [options [parameters]]\n"
	printf "\nOptions:\n"
	printf -- "-i|--interface, Provide a value for interface in ifconfig commands\n"
	printf -- "-h|--help, Print help\n"

return 0
}

while [ ! -z "$1" ]; do
	if [[ "$1" == "--help" ]] || [[ "$1" == "-h" ]];then
		show_usage
	elif [[ "$1" == "--interface" ]] || [[ "$1" == "-i" ]];then
		ifconfig $2 down
		ifconfig $2 hw ether $mac
		ifconfig $2 up
		shift
	else
		echo "Incorrect input provided"
		show_usage
	fi
shift
done
