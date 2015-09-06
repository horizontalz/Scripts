#!/bin/sh
## CCE/Securing Data and the Operating System/Managing User Accounts/Challenge ?: Remove all users from admin group that aren't supposed to be admin

## Variables
## List users who are authorized to be admins.  Separate multiple users with a pipe.
admins="root|dannylee"
## Converts string output into list
str=$(dscl . -read /Groups/admin GroupMembership)
arr=( $str )
## Output file to cat multiple variables for removing more than one user from admin group
for i in "${arr[@]}"; do echo $i; done | tail -n +2 | egrep -v $admins > /Users/dannylee/Desktop/list.txt
for u in $(cat /Users/dannylee/Desktop/list.txt)
 do

            /usr/sbin/dseditgroup -o edit -d $u -t user admin
            echo Removed $user from admin group
            rm /Users/dannylee/Desktop/list.txt

    done
