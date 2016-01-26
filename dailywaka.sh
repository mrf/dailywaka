#!/bin/bash

now=$(date -I)
baseurl="https://wakatime.com/api/v1/"
durations="users/current/durations/"

#Load API Key from file named config.txt
while read -r line
do
  api_key=$line
done < config.txt
#Encode our key before sending request
api_key=$(echo "$api_key" | base64)
auth="Authorization: Basic $api_key"
command="$baseurl""$durations"?date="$now"

response=$(/usr/bin/curl --silent --header "$auth" "$command")
#echo $response
duration=$(echo "$response" | grep -o "duration\"\:.*" | cut -f2- -d':')

if [[ -z "$duration" ]]; then
  notify-send -i \
    "Daily Waka" \
    "Time to write some code!"
fi
