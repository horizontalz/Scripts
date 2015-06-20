#!/bin/sh
variable=$(cat "/Users/dlee/meraki_list.txt")
for i in $(echo $variable)
do
find /Library/Payloads/Meraki/"$i" -iname "*student*.pkg"
done
