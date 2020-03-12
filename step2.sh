#!/bin/bash
inputfile="./clients.txt"
SaveIFS=$IFS
IFS="="
while read  key var
do
#   echo "opsi-admin -d method host_createOpsiClient $id $hk '"$desc"' '""' '"$mac"'" >> command.sh


if [ "$key" == "ident" ]
then
echo -n $var\; >> clients.csv
fi


if [ "$key" == "description" ]
then
echo -n $var\; >> clients.csv
fi


if [ "$key" == "hardwareAddress" ]
then
echo -n $var\; >> clients.csv
fi


if [ "$key" == "opsiHostKey" ]
then
echo $var >> clients.csv
fi



done < "$inputfile"
IFS=$SaveIFS



echo "remove first 1.5 strings befire 1sk client"