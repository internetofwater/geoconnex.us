#!/bin/bash

# Each 'run' generates 10 unique URLs, so if RUNS=10 you'll get 100 lines out.

TIME_START=$(date +%s)
FILE=sample-large.csv
RUNS=1000

if test -f "$FILE"; then
    truncate -s 0 $FILE
else
    touch $FILE
fi

for (( i=1; i <= $RUNS; i++)); do
    string=$(pwgen 10 1)
    echo "http://$string.co.uk, $string-1 UK, $string-1" >> $FILE
    echo "http://$string.net, $string-2 NET, $string-2" >> $FILE
    echo "http://$string.org, $string-3 ORG, $string-3" >> $FILE
    echo "http://$string.org.uk, $string-4 UK, $string-4" >> $FILE
    echo "http://$string.eu, $string-5 EU, $string-5" >> $FILE
    echo "http://$string.ie, $string-6 IDK, $string-6" >> $FILE
    echo "http://$string.irish, $string-7 IR, $string-7" >> $FILE
    echo "http://$string.cymru, $string-8 ID, $string-8" >> $FILE
    echo "http://$string.wales, $string-9 WA, $string-9" >> $FILE
    echo "http://$string.scot, $string-0 SC, $string-0" >> $FILE

    if [[ $(( $i % 100 )) -eq "0" ]]; then
        echo "Done $(wc -l $FILE | cut -d " " -f 1) lines."
    fi
done

TIME_TAKEN=$(( ($(date +%s) - $TIME_START) ))

echo
echo "$(wc -l $FILE | cut -d " " -f 1) lines."

echo
ls -gh $FILE

echo
echo "Took ${TIME_TAKEN}s."
