#!/bin/sh

USER=$(dscl . -list /Users UniqueID | grep 503 | awk '{print $1}')

dscl . -delete /Users/$USER
dscl . -delete /Groups/admin GroupMembership $USER

cat <<EOF >/foo.txt

EOF

#Removes Windows style carriage returns in copied textile
tr '\r' '\n' </foo.txt> /foo2.txt

## Grabs MAC address from first network interface
NIC=$(networksetup -getmacaddress en0 | awk '{print $3}')
## Grabs name from second tab in text file
COMPNAME=$(grep -i "$NIC" /foo2.txt | awk '{print $2}')

## Grabs username from database
LONGNAME=$(grep -i "$NIC" /foo2.txt | awk '{print $3,$4}')
SHORTNAME=$(grep -i "$NIC" /foo2.txt | awk '{print $5}')


## Sets computer, host, and local names

scutil --set ComputerName "$COMPNAME"
scutil --set HostName "$COMPNAME"
scutil --set LocalHostName "$COMPNAME"


# Create Teacher account
dscl . -create /Users/$SHORTNAME
dscl . -create /Users/$SHORTNAME UserShell /bin/bash
sudo dscl . -create /Users/$SHORTNAME RealName "$LONGNAME"
dscl . -create /Users/$SHORTNAME UniqueID 503
dscl . -create /Users/$SHORTNAME PrimaryGroupID 1000
dscl . -create /Users/$SHORTNAME NFSHomeDirectory /Users/$SHORTNAME
dscl . -passwd /Users/$SHORTNAME Welc0me1
dscl . -append /Groups/admin GroupMembership $SHORTNAME
dscl . -create /Users/$SHORTNAME picture "/Library/User Pictures/Fun/Chalk.tif"

jamf recon

# Delete temp database files

srm /foo.txt
srm /foo2.txt

