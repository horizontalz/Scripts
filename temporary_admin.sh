#!/bin/sh
##CSE/Securing Data and the Operating System/Managing User Accounts/Challenge "D":  Allow end users to temporarily access to admin priviledges but log all changes to the system during this time

## Variables
DT=$(date)
COMPNAME=$(hostname)
user=$(stat -f%Su /dev/console)
is_user_admin=$(dscl . -read /Groups/admin GroupMembership | grep $user)

## Verify user is admin or not
if [ -z "$is_user_admin" ]; then
## Add user to admin group
dscl . -append /Groups/admin GroupMembership $user
## Enable logging in background and print to timestamped txt file in /var
opensnoop > /var/$COMPNAME-$user-$DT.txt &
## Set temporary access time in seconds
sleep 120
## Remove user from admin group
dscl . -delete /Groups/admin GroupMembership $user
## Stop logging
killall dtrace
fi
