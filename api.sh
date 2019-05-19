IFS=$'\n'

slug=$1
api_url="https://twist.moe/api/anime/${slug}/sources"

json=$(curl -s "${api_url}" -H 'x-access-token: 1rj2vRtegS8Y60B3w3qNZm5T2Q0TN2NR')
links=$(echo $json | python ../jsonP.py)
for link in $links
do
# echo $link
python ../decrypt.py $link
done
