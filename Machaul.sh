#!/bin/bash
osascript <<EOD
##Set Full Name of User
display dialog "What is the full name of this User?" default answer ""
set fullName to text returned of result
set quotedFullName to quoted form of fullName

##Set Short Name of User
display dialog "What is your short name?" default answer ""
set shortName to text returned of result

##Set password for User
display dialog "What is the password this User?" default answer "Welc0me1"
set pass to text returned of result
set quotedPassword to quoted form of pass

##Set UID for User
display dialog "What is the UID this User?" default answer "510"
set UID to text returned of result

##Select Folder
tell application "Finder"
	
	set FolderPath to (choose folder) -- sets file path to folder you select
	set quotedVolume to quoted form of POSIX path of FolderPath
	
end tell

set availiableSize to do shell script "df -b / | grep 'disk1' | awk '{print $4}'"
set folderSize to do shell script "du -s " & FolderPath & " -print 2>/dev/null | sed 's/[^0-9]*//g'"

if availiableSize is less than folderSize then
	display dialog "There is not enough disk space to copy this folder over."
	do shell script "afplay /System/Library/Sounds/Basso.aiff"
	error number -128
end if

##Check if user folder exists already
set this_folder to "Macintosh HD:Users:" & shortName & ":"
tell application "Finder"
	if (exists folder this_folder) then
		display dialog "Folder exists.  Please delete existing account then run Machaul again."
		do shell script "afplay /System/Library/Sounds/Basso.aiff"
		error number -128
	end if
end tell

##Set progress bar
set n to 10
set progress total steps to n
set progress description to "Script Progress"
set progress additional description to "This might take awhile."
repeat with i from 1 to n
	delay 1
	set progress completed steps to i
end repeat

## Create user folder locally and copy data from external drive
do shell script "createhomedir -c -u " & shortName & "" with administrator privileges

## Merge folder to /Users
do shell script "ditto --rsrc " & quotedVolume & " /Users/" & shortName & "/" with administrator privileges

## Create user with dscl
do shell script "dscl . -create /Users/" & shortName & "" with administrator privileges
do shell script "dscl . -create /Users/" & shortName & " UserShell /bin/bash" with administrator privileges
do shell script "dscl . -create /Users/" & shortName & " RealName " & quotedFullName & "" with administrator privileges
do shell script "dscl . -create /Users/" & shortName & " UniqueID " & UID & "" with administrator privileges
do shell script "dscl . -create /Users/" & shortName & " PrimaryGroupID 1000" with administrator privileges
do shell script "dscl . -create /Users/" & shortName & " NFSHomeDirectory /Users/" & shortName & "" with administrator privileges
do shell script "dscl . -passwd /Users/" & shortName & " " & quotedPassword & "" with administrator privileges
do shell script "dscl . -append /Groups/admin GroupMembership " & shortName & "" with administrator privileges

##Set permissions on user folder
do shell script "chown -R " & shortName & ":staff /Users/" & shortName & "" with administrator privileges

##Notify process is complete
display dialog "All done"
do shell script "afplay /System/Library/Sounds/Basso.aiff"
EOD
