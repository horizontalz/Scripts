#!bin/sh

find /Library/GarageBand\ Loops\ I/ -iname "*.pkg" -exec installer -pkg '{}' -target / \;
