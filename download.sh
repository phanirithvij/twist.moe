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
total=`cat list.txt | wc -l`
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

if [[ "$s" == "a" ]]
then
    count=0
    for i in $(cat list.txt)
    do
        count=$((count+1))
        name=$anime-$count.mp4
        echo "downloading $i as $name"
        if [[ $CURL_TRUE == "yes" ]]
        then
            i=${i%$'\r'}
            curl -L -o $name -C - "$i" -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36'
        else
            wget -c -q --show-progress $i -O $name
        fi
        echo $i
    done
else
    j=1
    for i in $(cat list.txt)
    do
        if [ $j -ge $s -a $j -le $e ]
        then
            name=$anime-$j.mp4
            echo "downloading $i as $name"
            if [[ $CURL_TRUE == "yes" ]]
            then
                i=${i%$'\r'}
                curl -L -o $name -C - "$i" -H 'user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36'
            else
                wget -c -q --show-progress $i -O $name
            fi
        fi
        j=$((j+1))
    done
fi
