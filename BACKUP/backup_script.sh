#!/bin/bash
FILES=/geoconnex.us/BACKUP/backup_current/*.xml
for f in $FILES
do
  echo "Posting file $f..."
  curl --user [name]:[password] https://geoconnex.us/pidsvc/controller?cmd=import -X POST -F "source=@$f" -H "Content-Type: multipart/mixed" 
  cat $f
done  
