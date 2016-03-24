#!/bin/bash

file="iostat-record.$(date +"%Y%m%d_%H%M%S")"
end=$((SECONDS+28800))

if [ -f ${file} ]
then
    echo "Error: The ${file} exist. Please choose another file to record the data"
    return 1
fi

while [ $SECONDS -lt $end ]; do
    iostat | tee -a ${file}
    sleep 10
    :
done
