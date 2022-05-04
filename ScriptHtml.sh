#!/bin/bash
 
JMETERPLUGINSCMD=JMeterPluginsCMD.sh
 

 
# run jmeter and produce a JTL csv report
jmeter -n -t  $WORKSPACE/hb_0324.jmx -l reportejenkins.jtl -e -o dashboard
 
# process JTL and covert it to a synthesis report as CSV
$JMETERPLUGINSCMD --generate-csv synthesis_results.csv --input-jtl reportejenkins.jtl --plugin-type SynthesisReport
$JMETERPLUGINSCMD --tool Reporter --generate-csv reports/aggregate_results.csv --input-jtl reportejenkins.jtl --plugin-type AggregateReport
 
$JMETERPLUGINSCMD --generate-png reports/ResponseTimesOverTime.png --input-jtl reportejenkins.jtl --plugin-type ResponseTimesOverTime --width 800 --height 600
$JMETERPLUGINSCMD --generate-png reports/TransactionsPerSecond.png --input-jtl reportejenkins.jtl --plugin-type TransactionsPerSecond --width 800 --height 600

java -jar $WORKSPACE/jmeter-junit-xml-converter-0.0.1-SNAPSHOT-jar-with-dependencies.jar reportejenkins.jtl reporteconvertido.xml
