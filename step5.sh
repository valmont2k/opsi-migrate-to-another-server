#!/bin/bash
inputfile="./clients.csv"
SaveIFS=$IFS
IFS=";"
while read  id desc mac hk
do
   echo "opsi-admin -d method host_createOpsiClient $id $hk '"$desc"' '""' '"$mac"'" >> command1.sh
done < "$inputfile"
IFS=$SaveIFS