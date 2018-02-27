#ID.SH WILL WORK ONLY WHEN EXACT SLUG IS KNOWN
#the out put is id="its id"

slug=$1
curl  -s https://animepahe.com/anime/$slug | grep 'getJSON' | cut -d "'" -f2 | cut -d "&" -f2
