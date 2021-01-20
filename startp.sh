#!/bin/bash
if [ ! -d Anime ]
then
    echo "Making Anime directory.."
    mkdir Anime
fi
cd Anime
pw=$(pwd)
IFS=$'\n'
if [ $# -ne 1 ]
then
    echo "Enter link from https://twist.moe/"
    read link
else
    link=$1
fi
if [[ "$link" == "https://twist.moe/a/"* ]]
then
    di=$(echo $link | cut -d "/" -f5)
else
    di=$link
    link="https://twist.moe/a/$link"
    echo URL: $link
fi
if [ ! -d $di ]
then
    echo "Creating $di"
    mkdir $di
fi
if [ -f $di/list.txt ]
then
    rm $di/list.txt
fi
string=$link
char="/"
sla=$(echo "${string}" | awk -F"${char}" '{print NF-1}')
x=$( echo $link | cut -d "/" -f6 )
if [[ $x == "" ]]
then
    if [ $sla -eq 4 ]
    then
        one='/1'
        link=$link$one
        echo "making it $link"
    fi
    if [ $sla -eq 5 ]
    then
        one='1'
        link=$link$one
        echo "making it $link"
    fi
fi
echo "Fetching info..."
slug=$di
# IFS=$' '
cd ..
for i in $(bash api.sh "${slug}")
do
    # j='https://twist.moe'
    j='https://twistcdn.bunny.sh'
    j=$j$i
    echo $j
    echo $j >> $pw/$di/list.txt
done
cd Anime
echo "Creating $di/list.txt"
echo "copying download.sh to $di"
cp ../download.sh $di/
echo "Done"
echo "Check the Anime/$slug folder"
echo "Enjoy"
#rm $pw/.temp.txt
#rm $pw/$di/.t.txt
cd ../
chmod 777 list.sh
./list.sh $di
