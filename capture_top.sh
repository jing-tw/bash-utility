#!/bin/bash

file="top-record.$(date +"%Y%m%d_%H%M%S")"
end=$((SECONDS+28800))

if [ -f ${file} ]
then
    echo "Error: The ${file} exist. Please choose another file to record the data"
    return 1
fi

while [ $SECONDS -lt $end ]; do
    top -b -n 1 | head -n 6 - | tee -a ${file}
    sleep 10
    :
done
