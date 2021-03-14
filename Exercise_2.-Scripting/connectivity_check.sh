#!/bin/bash
# The name of bash script is connectivity_check.sh Created by Jorge Castilla
name=””
myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
#echo "My WAN/Public IP address: ${myip}"
name=`host ${myip}

if ping -q -c 1 -W 1 ${myip}>/dev/null; then
  echo "Router is up and running"
else
  echo "Router is down"
fi