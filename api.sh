#!/bin/bash
IFS=$'\n'

slug=$1
api_url="https://api.twist.moe/api/anime/${slug}/sources"

json=$(curl -s "${api_url}" -H 'x-access-token: 0df14814b9e590a1f26d3071a4ed7974')
rm .temp.txt
for data in $(echo $json | python ../jsonP.py)
do
    echo $data >> .temp.txt
done

python ../decrypt.py .temp.txt file > .data.txt
cat .data.txt
