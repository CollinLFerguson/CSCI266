#!/bin/bash

addUser(){
	username=$1
	password=$2
	homedir=$3
	shell = $4
	#-z checks if it is null before removing
	if [ -z "$homedir" ]; then 
		homedir="/home/$username"
	fi    

	if [ -z "$shell" ]; then
		shell="/bin/bash"
	fi
    
	sudo useradd -m -s $shell -d $homedir -p $password $username
    
}
deleteUser(){
	username=$1
	removeHomeAndMail=$2
	
	#the &>dev/null is used to remove the output from id
	if id "$username" &>/dev/null; then 
		if [ "$removeHomeAndMail" == true ]; then    
			sudo userdel -r $username
		else
			sudo userdel $username
		fi
	fi
}

printUser()
{
	username=$1
	userInfo=$(grep "^$username:" /etc/passwd)
	if [ -z "$userInfo" ]; then
		echo "That user does not exist"
	else
		echo "UID: $(echo "$userInfo" | cut -d: -f3)"
		echo "GID: $(echo "$userInfo" | cut -d: -f4)"
		echo "Home Dir: $(echo "$userInfo" | cut -d: -f6)"
		echo "Shell: $(echo "$userInfo" | cut -d: -f7)"
	fi
}

if [ "$1" == "create" ]; then
	addUser "$2" "$3" "$4" "$5"
fi

if [ "$1" == "delete" ]; then
	deleteUser "$2" "$3"
fi
if [ "$1" == "info" ]; then
	printUser "$2"
fi
