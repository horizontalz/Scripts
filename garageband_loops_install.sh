#!/bin/sh
## After copying loops, use this script to batch install the packages.

find /Library/GarageBand\ Loops\ I/ -iname "*.pkg" -exec installer -pkg '{}' -target / \;
