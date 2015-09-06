#!/bin/sh

cat <<EOF >/foo.txt
98:E0:D9:A2:5A:F7	BP-ST-ETurner	Erin	Turner	eturner
98:E0:D9:A2:B2:FD	DU-ST-SYarbrough	Scott	Yarbrough	syarbrough
98:E0:D9:A2:A5:1F	GD-ST-DYoshinaga	Dawn	Yoshinaga	dyoshinaga
98:E0:D9:A2:A5:73	GH-ST-CRoss	Cora	Ross	cross
98:E0:D9:A2:93:DB	GH-ST-MSardana	Manju	Sardana	msardana
98:E0:D9:A2:B1:8B	GH-ST-JSelfridge	Jacqueline	Selfridge	jselfridge
98:E0:D9:A1:FC:8F	GH-ST-LTabuchi	Lynn	Tabuchi	ltabuchi
98:E0:D9:A2:9C:FF	PH-ST-ASzebert	Alicia	Szebert	aszebert
98:E0:D9:A2:87:13	PH-ST-BWilson	Brian	Wilson	bwilson
98:E0:D9:A2:5B:13	PV-ST-NVatkina	Nina	Vatkina	nvatkina
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
dscl . -create /Users/$SHORTNAME UniqueID 502
dscl . -create /Users/$SHORTNAME PrimaryGroupID 1000
dscl . -create /Users/$SHORTNAME NFSHomeDirectory /Users/$SHORTNAME
dscl . -passwd /Users/$SHORTNAME Welc0me1
dscl . -append /Groups/admin GroupMembership $SHORTNAME
dscl . -create /Users/$SHORTNAME picture "/Library/User Pictures/Fun/Chalk.tif"

jamf recon

# Delete temp database files

srm /foo.txt
srm /foo2.txt

