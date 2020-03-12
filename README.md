# opsi-migrate-to-another-server

migtare opsi 

Привет!

Если кто - то заинтересован в том, как я реализовал миграцию сервера и клиента с помощью методов API (есть, вероятно, 1000 более простых способов, но я пошел по этому пути): 

сначала был установлен новый сервер с новым именем и IP. С помощью opsi-product-updater были установлены пакеты uib. Впоследствии программные пакеты были сняты со старого сервера с вашим .opsi файл записан. Но это не касалось пакетов uib.
Сначала я вытащил данные из старой системы. Это произошло на старом сервере для клиентов со следующей командой, которая затем была перенаправлена в CSV-файл:
КОД: ВЫБРАТЬ ВСЕ

opsi-admin -d -S method host_getObjects
(Это-S для более простого представления) 
таким образом, я получил наиболее важные данные о клиентах (имя ,описание, opsiHostKey, MAC) 

то же самое было сделано с помощью следующей команды для продуктов на клиентах:
КОД: ВЫБРАТЬ ВСЕ

opsi-admin -d -S method productOnClient_getObjects


После этого я смог редактировать CSV-файлы с помощью Notepad++ и с помощью "найти и сделать" - > удалить макросы/немаркированные и преобразовать их в следующие CSV-файлы с помощью макросов:> 
Clientname.Домен;описание; ee:ee:ee:ee:ee: ee: ee: ee;29510042456ebe244e1acc6cf88a8b3b (HOSTKEY) 

с помощью сценария оболочки я мог бы прочитать этот CSV-файл и создать из него сценарий оболочки, который создавал хосты с помощью API:
КОД: ВЫБРАТЬ ВСЕ

#!/bin/bash
inputfile="./opsi-clients.csv"
SaveIFS=$IFS
IFS=";"
while read  id desc mac hk
do
   echo "opsi-admin -d method host_createOpsiClient $id $hk '"$desc"' '""' '"$mac"'" >> command.sh
done < "$inputfile"
IFS=$SaveIFS


Один "command.sh вышел удалось выполнить" какой я и чем тогда все клиенты через API. (Внимание! Удалить сам opsiserver из списка) 

с сопоставлениями продуктов путь был аналогичным. Настройка с помощью Notepad++, пока не вышло следующее: 
clientid;запрос действия; версия SW; версия пакета; статус установки; идентификатор продукта 

затем снова с помощью сценария оболочки, чтобы собрать команды API:
КОД: ВЫБРАТЬ ВСЕ

inputfile="./products-on-clients.csv"
SaveIFS=$IFS
IFS=";"
while read clientid actreq provers pavers inststat prodid
do
   echo "opsi-admin -d method setProductState $prodid $clientid '"$inststat"' '"$actreq"' '"$provers"' '"$pavers"'" >> prod-command.sh

done < "$inputfile"

IFS=$SaveIFS


А затем запустите" выпадающий " скрипт. Это понадобилось тогда около 500 клиентов ученица 3 часа, так как для каждого клиента все продукты и были изложены требования к установке. 

после этого мне просто нужно было установить параметр "configserver" через Configed на старом сервере.url " на новом сервере и после двух перезагрузок (первый получает новый config от старого сервера, а второй он уже входит в систему на новом сервере).
Это можно контролировать с помощью значения" lastSeen " в ConfigEd.

Может быть, это поможет тому или иному в миграции. 
Если что-то еще не совсем ясно, просто дайте мне знать.

Поздравления


from here https://forum.opsi.org/viewtopic.php?t=9249

what to do:


1) install all *.opsi packets from old server to new
2) clone this repo to old opsi server
3) chmod +x step*
4) run step1.sh
5) run step2.sh
6) remove first 1.5 strings from cliens.csv file
7) run step3.sh
8) run step4.sh
9) run step5.sh
10) run step6.sh
11) move command1.sh file to new server and run it
12) move command2.sh file to new server and run it

it's all!










