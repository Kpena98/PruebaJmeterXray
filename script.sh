#!/bin/bash
csvFile=$1
projectName=$2
reportFile=$3
varDate=$(date +%c)
rm $reportFile
docker run --rm -v $WORKSPACE:/workspace swethapn14/repo_perf:JmeterLatest -Jjmeterengine.stopfail.system.exit=true -Jcsvfile=/workspace/$csvFile -n -t /workspace/$projectName -l /workspace/$reportFile
rm reporteconvertido.xml
java -jar $WORKSPACE/jmeter-junit-xml-converter-0.0.1-SNAPSHOT-jar-with-dependencies.jar reportejenkins.jtl reporteconvertido.xml
mv $WORKSPACE/alternate_reporteconvertido.xml $WORKSPACE/reportefinal.xml
if grep "false" $reportFile > resultadoemail.txt && echo "El Nombre del Job es:" $JOB_NAME >> resultadoemail.txt && echo "La fecha y hora de la ejecucion fue:" $varDate >> resultadoemail.txt && echo "El test de perfomance fallo" >> resultadoemail.txt
then 
echo El test fallo
exit 1
else grep "true" $WORKSPACE/$reportFile > resultadoemail.txt && echo "El Nombre del Job es:" $JOB_NAME >> resultadoemail.txt && echo "La fecha y hora de la ejecucion fue:" $varDate >> resultadoemail.txt && echo "El test de perfomance paso" >> resultadoemail.txt
echo El test finalizo correctamente
exit 0
fi
