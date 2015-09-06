#!/bin/sh
## CCE/Securing Data and the Operating System/Managing User Accounts/Challenge "D":  Allow end users to temporarily access to admin priviledges but log all changes to the system during this time

## Variables
DT=$(date)
COMPNAME=$(hostname)
user=$(stat -f%Su /dev/console)
## Converts string output into list
str=$(dscl . -read /Groups/admin GroupMembership)
arr=( $str )
##  Removes first line (GroupMembership:) and greps out user to see if in admin group
is_user_admin=$(for i in "${arr[@]}"; do echo $i; done | tail -n +2 | grep $user)

## Create logout shell script to kill allowed admin time
cat <<EOF >/var/foo.sh
#!/bin/sh
killall sleep
EOF
## Make script executable
chmod u+x /var/foo.sh
## Add script to logouthook
defaults write com.apple.loginwindow LogoutHook /var/foo.sh

## If no output, then user is not admin
if [ -z "$is_user_admin" ]; then
## Add user to admin group
dscl . -append /Groups/admin GroupMembership $user
## Enable logging in background and print to timestamped txt file in /var
opensnoop > /var/$COMPNAME-$user-$DT.txt &
## Set temporary access time in seconds
sleep 120
## Demote user from administrator
dscl . -delete /Groups/admin GroupMembership $user
## Stop logging
killall dtrace
## Remove logout hook
defaults delete com.apple.loginwindow LogoutHook
## Delete logout hook shell script
rm /var/foo.sh
## Notify user they are no longer admin
osascript -e 'tell app "System Events" to display dialog "Your allowed time with administrative privileges is over."'
fi 