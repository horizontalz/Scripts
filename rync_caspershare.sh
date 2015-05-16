
#!/bin/sh

mount_afp "afp://username:password@ip-address/CasperShare" /Volumes/CasperShare

sleep 5

find /Volumes/CasperShare/Packages -type f -name "*GH-*" -exec rsync -av '{}' /Users/gunn_admin/Desktop/Packages \;

find /Volumes/CasperShare/Packages -type f -name "*Firefox-*" -exec rsync -av '{}' /Users/gunn_admin/Desktop/Packages \;

osascript -e 'tell app "System Events" to display dialog "All Done"'
