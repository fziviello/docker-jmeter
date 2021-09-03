#!/bin/bash

REPORT_JTL=result.jtl
REPORT_CSV=result.csv
IFS=','
[ ! -f $REPORT_JTL ] && { echo "$REPORT_JTL file not found"; exit -1; }
sed -r '/^\s*$/d' < $REPORT_JTL > $REPORT_CSV

declare -i test_passed=0
declare -i test_failed=0

while read timeStamp elapsed label responseCode responseMessage threadName dataType success failureMessage bytes sentBytes grpThreads allThreads URL Latency IdleTime Connect
do
    if [ "$success" == 'true' ] || [ "$success" == 'false' ]
    then
        if [ "$success" == 'true' ]
        then
             test_passed=$(( test_passed + 1 ))
             echo $label "-> ["$URL"] Status Code:" $responseCode "(PASSED)"
        else
            test_failed=$(( test_failed + 1 ))
             echo $label "-> ["$URL"] Status Code:" $responseCode "(FAILED)"
        fi
    fi
done < $REPORT_CSV
rm -rf $REPORT_CSV

echo TEST = $(( test_passed + test_failed ))
echo TEST PASSED = $test_passed
echo TEST FAILED = $test_failed

if [ "$test_failed" != 0 ]
then
    exit -2
fi