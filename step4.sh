#!/bin/bash
inputfile="./packets.txt"
SaveIFS=$IFS
IFS="="
while read  key var
do
#   echo "opsi-admin -d method host_createOpsiClient $id $hk '"$desc"' '""' '"$mac"'" >> command.sh


if [ "$key" == "clientId" ]
then
echo -n $var\; >> ./packets.csv
fi


if [ "$key" == "actionRequest" ]
then
echo -n $var\; >> ./packets.csv
fi


if [ "$key" == "productVersion" ]
then
echo -n $var\; >> ./packets.csv
fi


if [ "$key" == "packageVersion" ]
then
echo -n $var\; >> ./packets.csv
fi


if [ "$key" == "installationStatus" ]
then
echo -n $var\; >> ./packets.csv
fi

if [ "$key" == "productId" ]
then
echo  $var >> ./packets.csv
fi


done < "$inputfile"
IFS=$SaveIFS