#OUTPUTS THE IDS AND THUMBNAILS in a array of objects named slug
#INPUT CAN BE SLUG OR ID
if [[ $1 =~ ^-?[0-9]+$ ]]
then	
anid='id='$1
slug=$(./slug.sh $anid)
else
slug=$1
anid=$(./id.sh $slug)
fi
page=1
link=$(echo https://animepahe.com/api?m=release\&$anid\&l=30\&sort=episode_asc\&page=$page)
echo LINK $link
currpage=0
lastpage=1 #something thats not currpage
totids=0
while [[ $currpage != $lastpage ]]
do
#echo ${id[*]}
link=$(echo https://animepahe.com/api?m=release\&$anid\&l=30\&sort=episode_asc\&page=$page)
echo LINK $link
wget -q -O page.json $link
echo var data = $(cat page.json) > dpage.json
cat dpage.json getbashcode.txt > dpage.js
node dpage.js > temp.sh
. temp.sh
cat temp.sh
echo ${id[*]}
echo from $start to $end
echo currpage $currpage / lastpage $lastpage
page=$((currpage+1))
echo page $page
done
x=0
rm -f out.json
#echo ${id[*]}
id=$(echo $anid | cut -d "=" -f2)
var=$(echo $slug | tr '-' '_')
echo "var $var = ["
echo "var $var = [" >> out$id.json
for i in ${id[*]}
do
	x=$((x+1))
	echo '{'
	echo '{' >> out$id.json
	echo \"id\":$i ,
	echo \"id\":$i , >> out$id.json
       	echo \"thumb\":${thumb[$x]}
       	echo \"thumb\":${thumb[$x]} >> out$id.json
	if [[ $totids != $x ]]
	then
	echo '},'
	echo '},' >> out$id.json
	else
	echo '}'
	echo '}' >> out$id.json
	fi
done
echo ']'
echo ']' >> out$id.json
