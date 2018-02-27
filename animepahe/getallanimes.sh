#OUTPUT IS (SLUG [tab] TITLE) for all anime in animepahe
rm -f allanimes.html
if [ -f paheslugs.txt ]
then
	mv paheslugs.txt paheoldslugs.txt
fi
wget -q -O allanimes.html https://animepahe.com/anime 
cat allanimes.html | grep -E '<li><h2>.*</h2></li>' | tr "\"" '~'| cut -d "~" -f2,4 | cut -d "/" -f3 | tr '~' '\t' > paheslugs.txt
