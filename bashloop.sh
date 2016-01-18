cat <<EOF >/foo.txt
/Applications/Chess.app
/Applications/CreateUserPkg.app
EOF

#Removes Windows style carriage returns in copied textile
tr '\r' '\n' </foo.txt> /foo2.txt

RES=$(cat /foo2.txt)

for i in $RES
do 
    find $i
done
