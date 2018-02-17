IFS=$'\n'
	echo 'anime = ['
	echo 'anime = [' > twistlinks.json
m=0
d=$(cat twlist.txt | wc -l)
for i in $(cat twlist.txt| awk -F"|" '{print $1}')
	do
	c=0
	echo '{'
	echo '{' >> twistlinks.json
	echo \"name\" : \"$i\" ,
	echo \"name\" : \"$i\" , >> twistlinks.json
	echo \"title\" : \"$(cat twlist.txt | grep -E '^'$i'\|\|' | awk -F"|" '{print $3}')\" ,
	echo \"title\" : \"$(cat twlist.txt | grep -E '^'$i'\|\|' | awk -F"|" '{print $3}')\" , >> twistlinks.json
	alt=$(cat twlist.txt | grep -E '^'$i'\|\|' | awk -F"|" '{print $5}')
	if [[ $alt == "false" ]]
	then
	echo \"alt\" : $(cat twlist.txt | grep -E '^'$i'\|\|' | awk -F"|" '{print $5}') , 
	echo \"alt\" : $(cat twlist.txt | grep -E '^'$i'\|\|' | awk -F"|" '{print $5}') , >> twistlinks.json
	else
	echo \"alt\" : \"$(cat twlist.txt | grep -E '^'$i'\|\|' | awk -F"|" '{print $5}')\" , 
        echo \"alt\" : \"$(cat twlist.txt | grep -E '^'$i'\|\|' | awk -F"|" '{print $5}')\" , >> twistlinks.json
	fi
	t=$(cat Anime/$i/list.txt | wc -l)
	for j in $(cat Anime/$i/list.txt)
	do
	c=$((c+1))
		echo -e "\"$c\" : \"$j\",\n"
		echo -e "\"$c\" : \"$j\",\n" >> twistlinks.json
	done
	m=$((m+1))
	echo \"total\" : $t
	echo \"total\" : $t >> twistlinks.json
	if [ $m -lt $d ]
	then	
	echo '},'
	echo '},' >> twistlinks.json
	else
	echo '}'
	echo '}' >> twistlinks.json
	fi
done
echo '];'
echo '];' >> twistlinks.json
