IFS=$'\n'

slug=$1
api_url="https://twist.moe/api/anime/${slug}/sources"

json=$(curl -s "${api_url}" -H 'x-access-token: 1rj2vRtegS8Y60B3w3qNZm5T2Q0TN2NR')
links=$(echo $json | python3 -c "import sys, json; sources = json.load(sys.stdin); [print(s['source']) for s in sources];")
for link in $links
do
python3 ../decrypt.py $link
done