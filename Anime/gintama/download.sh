wget_or_curl(){
	if ! [ -x "$(command -v curl)" ]; then
		CURL_TRUE="no"
	else
		CURL_TRUE="yes"
	fi
}

wget_or_curl
echo "curl is installed" $CURL_TRUE

IFS=$'\n'
l=`cat list.txt | wc -l`
if [ $# -ne 2 ]
then
	echo Total no of episodes : $l
	echo Enter \'a\' for all episodes
	echo start at:
	read s
	if [[ $s != "a" ]]
	then
		echo end at:
		read e
	fi
else 
	s=$1
	e=$2
fi
if [[ "$s" == "a" ||  "$e" == "a" ]]
then
	for i in $(cat list.txt)
	do
		if [[ $CURL_TRUE == "yes" ]]
		then
			curl -g -L -O -C - $i
		else
			wget -c -q --show-progress $i
		fi
		echo $i
	done
else
	j=1
	for i in $(cat list.txt)
	do
		if [ $j -ge $s -a $j -le $e ]
		then
			if [[ $CURL_TRUE == "yes" ]]
			then
				# https://stackoverflow.com/a/35019553/8608146
				i=${i%$'\r'}
				curl -L -O -C - "$i" -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36'
			else
				wget -c -q --show-progress $i
			fi
		fi
		j=$((j+1))
	done
fi
