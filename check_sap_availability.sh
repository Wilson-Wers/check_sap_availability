#!/bin/bash

##################################################################
# Script: check_sap_availability.sh                              #
# Author: Wilson Fernandes                                       #
# Contact: Email: wilsonwers@gmail.com                           #
# Date: 2019-08-15                                               #
# Description: Monitoramento Disponibilidade SAP                 #
# Use: check_sap_availability.sh hdbnameserver 00                #
##################################################################

SAPCMD="/usr/sap/hostctrl/exe/saphostctrl"

case ${1} in

database)
DATA=$(${SAPCMD} -function ListInstances | awk '{print $4" "$6}')
echo "{"
echo "\"data\":["
comma=""
while read NAME COD
do
echo "    $comma{\"{#NAME_ID}\":\"$NAME\" ,"
echo "    \"{#COD_ID}\":\"$COD\"}"
comma=","
#       echo -n "{\"{#NAME_ID}\":\"$NAME\"},"
#       echo -n "{\"{#COD_ID}\":\"$COD\"}"
done << EOF
$DATA
EOF
echo "]"
echo "}"
#echo -e '\b]}'
;;
hdbdaemon)
A=$(/usr/sap/hostctrl/exe/sapcontrol -nr ${2:-00} -function GetProcessList |\
grep hdbdaemon |\
awk -F',' '{print $4}' | tr -d ' ' )
[[ "$A" == "Running" ]] && echo "0" || echo "1"
;;
hdbcompileserver)
A=$(/usr/sap/hostctrl/exe/sapcontrol -nr ${2:-00} -function GetProcessList |\
grep hdbcompileserver |\
awk -F',' '{print $4}' | tr -d ' ' )
[[ "$A" == "Running" ]] && echo "0" || echo "1"
;;
hdbindexserver)
A=$(/usr/sap/hostctrl/exe/sapcontrol -nr ${2:-00} -function GetProcessList |\
grep hdbindexserver |\
awk -F',' '{print $4}' | tr -d ' ' )
[[ "$A" == "Running" ]] && echo "0" || echo "1"
;;
hdbnameserver)
A=$(/usr/sap/hostctrl/exe/sapcontrol -nr ${2:-00} -function GetProcessList |\
grep hdbnameserver |\
awk -F',' '{print $4}' | tr -d ' ' )
[[ "$A" == "Running" ]] && echo "0" || echo "1"
;;
hdbpreprocessor)
A=$(/usr/sap/hostctrl/exe/sapcontrol -nr ${2:-00} -function GetProcessList |\
grep hdbpreprocessor |\
awk -F',' '{print $4}' | tr -d ' ' )
[[ "$A" == "Running" ]] && echo "0" || echo "1"
;;
hdbwebdispatcher)
A=$(/usr/sap/hostctrl/exe/sapcontrol -nr ${2:-00} -function GetProcessList |\
grep hdbwebdispatcher |\
awk -F',' '{print $4}' | tr -d ' ' )
[[ "$A" == "Running" ]] && echo "0" || echo "1"
;;
hdbxsengine)
A=$(/usr/sap/hostctrl/exe/sapcontrol -nr ${2:-00} -function GetProcessList |\
grep hdbxsengine |\
awk -F',' '{print $4}' | tr -d ' ' )
[[ "$A" == "Running" ]] && echo "0" || echo "1"
;;
*)
echo "ZBX_NOTSUPPORTED: Unsupported item key."
;;
esac
