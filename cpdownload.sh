IFS=$'\n'
for i in $(ls Anime)
do
	cp download.sh Anime/$i/
done
