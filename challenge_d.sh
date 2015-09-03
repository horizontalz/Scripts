#!/bin/sh
user=$(stat -f%Su /dev/console)
computername=$(hostname)


curl -X PUT -H "Accept: application/xml" -H "Content-type: application/xml" -k -u jamfadmin:Jamf1234 -d "<computer><location><username>$user</username></location></computer>" https://192.168.10.55:8443/JSSResource/computers/name/$hostname
