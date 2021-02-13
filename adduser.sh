#!/bin/bash

#by Andy.od.ua

echo "user add, version 1"
echo "copyright (c) 2007 Andrew M <andy.od.ua>"

if [ -z "$1" ]
then
	echo "User name empty"
	echo "Usage useradd user_name"
	exit
fi	

USER_NAME=$1

function create_user(){
    local login="$1"
    local password="$2"
    `useradd -m -s /bin/bash $login`
    `chmod a-w /home/$login`
    echo -e "$password\n$password\n" | passwd $login >> /dev/null
}
function is_user(){
    local check_user="$1";
    grep "$check_user:" /etc/passwd >/dev/null
    if [ $? -ne 0 ]; then
		return 1
    else
		return 0
    fi
}
function rand_pass(){ 
	< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c${1:-10};echo;
}
USER_PASSWORD="$(rand_pass)"

echo -n "Check user name $USER_NAME: "
if( is_user "$USER_NAME" )then
    echo "User already exits!"
else
    create_user "$USER_NAME" "$USER_PASSWORD"
	echo "----------Create User--------------"
	echo "User name    : $USER_NAME"
	echo "User password: $USER_PASSWORD"
	echo "-----------------------------------"	
fi

echo "Have a nice day :)"

exit
