#!/bin/bash
IFS=$'\n'

slug=$1
api_url="https://twist.moe/api/anime/${slug}/sources"

json=$(curl -s "${api_url}" -H 'x-access-token: 1rj2vRtegS8Y60B3w3qNZm5T2Q0TN2NR')
rm .temp.txt
for data in $(echo $json | python ../jsonP.py)
do
    echo $data >> .temp.txt
done

python ../decrypt.py .temp.txt file > .data.txt
cat .data.txt
