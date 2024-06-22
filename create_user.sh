#!/bin/bash

#Script should be execute with sudo/root access.

if [[ "${UID}" -ne 0 ]]
then
        echo 'please run  with sudo or  root.'
        exit 1
fi


#User  should provide at least single argument as username else guide him

if [[ "${#}" -lt 1]]
then
        echo "Usage: ${0} USER_NAME [COMMENT]..."
        echo 'create a user with name USER_NAME and comments field of COMMENT'
        exit 1
fi


#Store 1st Argument as USER NAME

USER_NAME="${1}"

#In case more than one argument, store it as comments
Shift
COMMENT="${@}"

#Create a password.
PASSWORD=$(date %sS%N)


#Create the user
useradd -c "$COMMENT" -m  $USER_NAME

#Check if user is successfully created or not
if [[ $? -ne 0 ]]
then
        echo 'Account could not be created'
        exit 1
fi


#Set the password for the user.
echo $PASSWORD | passwd --stdin $USER_NAME


#Check if password is successfully set or not
if [[ $? -ne 0 ]]
then
        echo 'Password could not be set'
        exit 1
fi

#Force password change on first login.
passwd -e $USER_NAME


#Display the user name , password, and the host where the user was created.
echo
echo "username: $USER_NAME"

