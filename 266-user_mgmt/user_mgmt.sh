#!/bin/bash
echo "----------------------" | tee -a logfile.log
echo "Input: $@" | tee -a logfile.log

addUser(){
	username=$1
	password=$2
	homedir=$3
	shell=$4

	#-z checks if it is null before removing
	if [ -z "$homedir" ]; then 
		homedir="/home/$username"
	fi    

	if [ -z "$shell" ]; then
		shell="/bin/bash"
	fi

	if [ -z "$password" ]; then 

		sudo useradd -m -s $shell -d $homedir $username
	else
		sudo useradd -m -s $shell -d $homedir -p $password $username
	fi 
    if [ $? -eq 0 ]; then
        echo "User was added successfully"
    else
        echo "User was not added successfully"
    fi

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
    
    if [ $? -eq 0 ]; then
        echo "User was deleted successfully"
    else
        echo "User was not deleted successfully"
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
	addUser "$2" "$3" "$4" "$5" | tee -a logfile.log
fi

if [ "$1" == "delete" ]; then
	deleteUser "$2" "$3" | tee -a logfile.log
fi
if [ "$1" == "info" ]; then
	printUser "$2" | tee -a logfile.log
fi
