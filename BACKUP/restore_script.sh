#!/bin/bash
FILES=backup_current/*.xml
for f in $FILES
do
  echo "Posting file $f..."
  curl http://localhost:8095/pidsvc/controller?cmd=import --form upload=@$f
  echo "Posted file $f"
done  
