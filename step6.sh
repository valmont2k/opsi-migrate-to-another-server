inputfile="./packets.csv"
SaveIFS=$IFS
IFS=";"
while read clientid actreq provers pavers inststat prodid
do
   echo "opsi-admin -d method setProductState $prodid $clientid '"$inststat"' '"$actreq"' '"$provers"' '"$pavers"'" >> command2.sh

done < "$inputfile"

IFS=$SaveIFS
