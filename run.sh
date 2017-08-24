#!/bin/bash

url=$WERCKER_WRITE_TO_INFLUXDB_URL
user=$WERCKER_WRITE_TO_INFLUXDB_USER
password=$WERCKER_WRITE_TO_INFLUXDB_PASSWORD
database=$WERCKER_WRITE_TO_INFLUXDB_DATABASE
port=$WERCKER_WRITE_TO_INFLUXDB_PORT
timestamp=$WERCKER_WRITE_TO_INFLUXDB_TIMESTAMP
measurement=$WERCKER_WRITE_TO_INFLUXDB_MEASUREMENT
value=$WERCKER_WRITE_TO_INFLUXDB_VALUE
tags==$WERCKER_WRITE_TO_INFLUXDB_TAGS
data_binary=$WERCKER_WRITE_TO_INFLUXDB_DATA_BINARY

# Account for default values
if [ ! $timestamp ]; then timestamp=$(date +%s); fi
if [ ! $port ]; then port="8086"; fi

# Resolve the data binary 
if [ ! $data_binary ]; then
    # Ensure that required information for data bindary is present.
    if [ ! $measurement ]; then echo "please provide a measurement"; exit; fi
    if [ ! $value ]; then echo "please provide a value"; exit; fi
    if [ ! $tags ]; then
        tags="";
    else
        tags=",$tags"
    fi
    
    # Create the data binary string as seen
    # [[here https://docs.influxdata.com/influxdb/v0.9/guides/writing_data/]]
    data_binary="$measurement$tags value=$value $timestamp"
fi

# Execute curl command
curl -i -XPOST -u '$user:$password' $url:$port/write?db=$database --data-binary '$data_binary'
