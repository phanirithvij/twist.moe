IFS=$'\n'
for i in $(cat twlist.txt)
do
	link=$(echo $i | cut -d"	" -f1)
	title=$(echo $i | cut -d"	" -f2)
	./startp.sh $link
done
