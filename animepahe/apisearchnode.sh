slug=$1
anid=$(./id.sh $slug)
page='1'
link=$(echo https://animepahe.com/api?m=release\&$anid\&l=30\&sort=episode_asc\&page=$page)
lastpage='null'
#while [[  ]]
#do
wget -q -O page$page.json $link
echo var data = $(cat page$page.json) > dpage$page.json
cat dpage$page.json getbashcode.txt > dpage$page.js
node dpage$page.js > temp.sh
source temp.sh
echo ${id[*]}
#done
