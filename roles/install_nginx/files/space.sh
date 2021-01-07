#!/usr/bin/env bash
# -*- coding: utf-8 -*-
echo "<html><head>"
echo "<title>space</title>"
echo '<meta http-equiv="Content-type"
content="text/html;charset=UTF-8">'
echo "</head><body>"

DF1=`df --output=source | tail -n +2`
DF2=`df --output=pcent | tail -n +2`

SOURCE=()
AVAIL=()

while IFS= read -r line; do
    # echo "$line"
    SOURCE+=("$line")
done <<< "$DF1"


while IFS= read -r line; do
    # echo "$line"
    REMAINING=$(expr 100 - ${line%\%})
    AVAIL+=(${REMAINING})
done <<< "$DF2"

for ((i = 0 ; i <= ${#SOURCE[@]} ; i++)); do
    echo "${SOURCE[$i]} : ${AVAIL[$i]}%</br>"
done

echo "</br>I need to figure out how to skip empty strings in bash.</br>"
echo "</body></html>"
