#!/bin/sh
## Install Meraki-ciconf
installer -pkg /Library/Payloads/Meraki/meraki-ciconf.pkg -target /

## Variables for site of computer and if this is a staff computer
SITE=$(hostname | awk -F"-" '{print $1}')
CLASS=$(hostname | awk -F"-" '{print $2}')

## Install Meraki Agent for iConnect Macs
if [[ "$SITE" == "iConnect" ]]
	then
		find /Library/Payloads/Meraki/"$SITE" -iname "iConnect*.pkg" -exec installer -pkg '{}' -target / \;
## Install Meraki Agent for DO Macs
elif [[ "$SITE" == "DO" ]]
	then
		find /Library/Payloads/Meraki/"$SITE" -iname "DO*.pkg" -exec installer -pkg '{}' -target / \;
## Install Meraki Agent for Staff Macs
elif [[ "$CLASS" == "ST" ]] || [[ "$CLASS" == "Staff" ]] || [[ "$CLASS" == "STAFF" ]] || [[ "$CLASS" == "TCHR" ]] || [[ "$CLASS" == "ADMIN" ]] || [[ "$CLASS" == "Admin" ]] && [[ "$SITE" != "iConnect" ]] && [[ "$SITE" != "DO" ]];
	then
		find /Library/Payloads/Meraki/"$SITE" -iname "*staff*.pkg" -exec installer -pkg '{}' -target / \;
## Install Meraki Agent for Student Macs
elif [[ "$CLASS" != "ST" ]] && [[ "$SITE" != "iConnect" ]] && [[ "$SITE" != "DO" ]];
	then
		find /Library/Payloads/Meraki/"$SITE" -iname "*students*.pkg" -exec installer -pkg '{}' -target / \;
fi

rm -rf /Library/Payloads
