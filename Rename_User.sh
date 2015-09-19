#!/bin/bash
osascript <<EOD
 set currentUser to do shell script "stat -f '%Su' /dev/console"

##Set Full Name of User
display dialog "What is your full name?" default answer ""
set fullName to text returned of result
set quotedFullName to quoted form of fullName

##Set Short Name of User
display dialog "What is your short name?" default answer ""
set shortName to text returned of result
set quotedShortName to quoted form of shortName

##Set Password
display dialog "What is the password this User?" default answer "Welc0me1"
set pass to text returned of result
set quotedPassword to quoted form of pass

##Set UID for User
display dialog "What is the UID this User?" default answer "502"
set UID to text returned of result

##do shell script "rm /Library/Preferences/com.microsoft.office.licensing.plist" with administrator privileges

do shell script "mv /Users/" & currentUser & " /Users/" & quotedShortName & "" with administrator privileges

## Create user with dscl
do shell script "dscl . -create /Users/" & quotedShortName & "" with administrator privileges
do shell script "dscl . -create /Users/" & quotedShortName & " UserShell /bin/bash" with administrator privileges
do shell script "dscl . -create /Users/" & quotedShortName & " RealName " & quotedFullName & "" with administrator privileges
do shell script "dscl . -create /Users/" & quotedShortName & " UniqueID " & UID & "" with administrator privileges
do shell script "dscl . -create /Users/" & quotedShortName & " PrimaryGroupID 1000" with administrator privileges
do shell script "dscl . -create /Users/" & quotedShortName & " NFSHomeDirectory /Users/" & quotedShortName & "" with administrator privileges
do shell script "dscl . -passwd /Users/" & quotedShortName & " " & quotedPassword & "" with administrator privileges
do shell script "dscl . -append /Groups/admin GroupMembership " & quotedShortName & "" with administrator privileges
do shell script "dscl . -delete /Users/" & currentUser & "" with administrator privileges

##Set permissions on user folder
do shell script "chown -R " & quotedShortName & ":staff /Users/" & quotedShortName & "" with administrator privileges

##Notify process is complete
display dialog "All done"
do shell script "killall loginwindow" with administrator privileges

EOD
