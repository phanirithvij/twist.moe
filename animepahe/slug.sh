id=$1
page=1
link="https://animepahe.com/api?m=release&id=$id\&l=2&sort=episode_asc&page=$page"
curl -s $link > o.json
slug=$(cat o.json | tr ',' '\n'| grep 'anime_slug' | sort -u | cut -d "\"" -f4)
echo $slug
