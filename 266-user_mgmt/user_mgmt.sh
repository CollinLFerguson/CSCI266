#!/bin/bash

logfile = 

addUser(){
	username = $1
	password = $2
	homedir = $3
	shell = $4

	if [-z "$homedir"]; then
		homedir = "/home/$username"
	fi    

	if [-z "$shell"]; then
		shell = "/bin/bash"
	fi
    
	sudo useradd -m -s $shell -d $homedir -p $password $username
    
}
deleteUser(){
	username = $1
	removeHomeAndMail = $2
	if id "$username" &>/dev/null; then #the &>dev/null is used to remove the output from id
		if ["$removeHomeAndMail" == true]; then    
			sudo userdel -r $username
		else
			sudo userdel $username
		fi
	fi
}
printUser()
{
	username = $1
	


}


