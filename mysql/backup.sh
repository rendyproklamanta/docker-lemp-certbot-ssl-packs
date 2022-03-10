#!/bin/bash
NOW=$(date +"%m-%d-%Y_%H-%M")
FILE="backup-$NOW.sql"

docker exec lemp-mariadb sh -c 'exec mysqldump -uroot -p"$MYSQL_ROOT_PASSWORD" --databases $MYSQL_DATABASE' > "backup/$FILE"

mysql -s -r -uroot -e 'show databases' -N | while read dbname; do 
    mysqldump -uroot --complete-insert --single-transaction "$dbname" > "backup/$dbname".sql; 
done

echo "Backing up data complate."