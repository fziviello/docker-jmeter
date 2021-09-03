#!/bin/bash

pwd
ls -a
REPORT_JTL=result.jtl
REPORT_CSV=result.csv
IFS=','
[ ! -f $REPORT_JTL ] && { echo "$REPORT_JTL file not found"; exit -1; }
sed -r '/^\s*$/d' < $REPORT_JTL > $REPORT_CSV
while read timeStamp elapsed label responseCode responseMessage threadName dataType success failureMessage bytes sentBytes grpThreads allThreads URL Latency IdleTime Connect
do
    if [ "$success" == 'true' ] || [ "$success" == 'false' ]
    then
        if [ "$success" == 'true' ]
        then
             echo "$label" : "$success"
        else
             exit -9
        fi
    fi
done < $REPORT_CSV
rm -rf $REPORT_CSV