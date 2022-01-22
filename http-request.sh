#!/bin/bash

urlToSend="https://en3osbv3nir72.x.pipedream.net/"
date=`date +%D`
time=`date +%T`

function usage(){
    echo ""
    echo "Use the numbers in front to select the file"
    echo "The selected file will be transmited"
    echo "Press x if you want to exit"
}
usage

filesArray=(`find -name "*.txt" | sed 's/.\///'`)

function showFilesArray(){
for i in ${!filesArray[@]}
do
    echo "$i. ${filesArray[i]}"
done
}
showFilesArray

while true
do
    echo -e "\n Which file to send?"
    read chosenFile

    if ! [ "$chosenFile" -ge 0 ] 2> /dev/null
    then
        if [[ "$chosenFile" == 'x' ]]
        then
            break 1
        fi
        echo "Please enter the coresponding number of a file"
        usage
    else
        curl -d '{ "fileName": "'"${filesArray[$chosenFile]}"'", "date": "'$date'", "time": "'$time'" }' \
        -H "Content-Type: application/json" \
        $urlToSend
    fi
done