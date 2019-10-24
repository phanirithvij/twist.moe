CURL_TRUE="no"

wget_or_curl(){
    if ! [ -x "$(command -v curl)" ]; then
        CURL_TRUE="no"
    else
        CURL_TRUE="yes"
    fi
}

wget_or_curl

anime=$(basename $PWD)
echo "anime is $anime"
echo "curl is installed: $CURL_TRUE"

IFS=$'\n'
total=$(cat list.txt | wc -l | xargs)

if [ $# -ne 2 ]
then
    echo Total no of episodes : $total
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

if [[ "$e" == "a" ]]
then
    e=$total
fi

# number of digits in the totalcount
maxpad=$(echo $total | wc -m)
# echo $total|wc -m
maxpad=$((maxpad-1))
if [[ "$s" == "a" ]]
then
    count=0
    for i in $(cat list.txt)
    do
        count=$((count+1))
        # https://stackoverflow.com/a/8789815/8608146
        printf -v paded_count "%0${maxpad}d" $count
        name=$anime-$paded_count.mp4
        # this is extremely important
        # without this the file will not download
        # the url will become a 404
        # https://stackoverflow.com/a/35019553/8608146
        i=${i%$'\r'}
        echo "downloading $name"
        if [[ $CURL_TRUE == "yes" ]]
        then
            curl -L -o $name -C - "$i" -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36' -H "Referer: https://twist.moe/"
        else
            wget -c -q --show-progress $i -O $name --header='user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36' --header="Referer: https://twist.moe/"
        fi || break
    done
else
    j=1
    for i in $(cat list.txt)
    do
        if [ $j -ge $s -a $j -le $e ]
        then
            printf -v paded_count "%0${maxpad}d" $j
            name=$anime-$paded_count.mp4
            echo "downloading $name"
            i=${i%$'\r'}
            if [[ $CURL_TRUE == "yes" ]]
            then
                curl -L -o $name -C - "$i" -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36' -H "Referer: https://twist.moe/"
            else
                wget -c -q --show-progress $i -O $name --header='user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36' --header="Referer: https://twist.moe/"
            fi || break
        fi
        j=$((j+1))
    done
fi
