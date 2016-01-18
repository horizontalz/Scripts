cat <<EOF >/foo.txt
/Applications/Chess.app
/Applications/Automator.app
/Applications/Cisco
/Applications/Freebird.app
/Applications/Maya.app
/Applications/Blackmagic Disk Speed Test.app
EOF

#Removes Windows style carriage returns in copied textile
tr '\r' '\n' </foo.txt> /foo2.txt

RES=$(cat /foo2.txt)
IFS=$'\n'       # make newlines the only separator
for i in $RES
do 
if [ ! -d $i ]; then
echo "$i" >> /foo3.txt
##else 
##echo "not missing"
##jamf install -package "$PKG" -path $DISTROPOINT/"$PKG" -target /
fi
done


if grep -Fxq /Applications/Maya.app /foo3.txt 
then
    say "needs Maya"
##else
    # code if not found
    fi



##    find $i
##done
