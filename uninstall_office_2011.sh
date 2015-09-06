#!/bin/sh
##Remove Office 2011 for Mac per https://support.office.com/en-sg/article/Uninstall-Office-2011-from-a-Mac-ba8d8d13-0015-4eea-b60b-7719c2cedd17

rm -rf /Applications/Microsoft\ Office\ 2011
rm ~/Library/Preferences/com.microsoft.*
rm ~/Library/Preferences/ByHost/com.microsoft.*
rm -rf ~/Library/Application\ Support/Microsoft
rm /Library/LaunchDaemons/com.microsoft.office.licensing.helper.plist
rm /Library/Preferences/com.microsoft.office.licensing.plist
rm /Library/PrivilegedHelperTools/com.microsoft.office.licensing.helper
rm -rf /Library/Application\ Support/Microsoft
rm -rf /Library/Fonts/Microsoft
rm /Library/Receipts/Office2011_*
rm /private/var/db/receipts/com.microsoft.office.*
mv ~/Documents/Microsoft\ User\ Data ~/Documents/Microsoft\ User\ Data_old

done