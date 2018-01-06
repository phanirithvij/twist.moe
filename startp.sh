#!/bin/bash
IFS=$'\n'
if [ $# -ne 1 ]
then
	echo Enter link from https://twist.moe/
	read link
else
	link=$1
fi
di=`echo $link | cut -d "/" -f5`
if [ ! -d $di ]
then
echo Creating $di
mkdir $di
fi
if [ -f $di/.t.txt ]
then
rm $di/.t.txt
fi
if [ -f $di/list.txt ]
then
rm $di/list.txt
fi
echo Fetching info...
curl -s $link | sed 's/\"/\n/g' | tr -s " " | egrep 'mp4|mkv|avi|ogg' | sed -e 's/^[ \t]*//' | sort -n | uniq | egrep mp4$ > $di/.t.txt
echo Creating $di/list.txt
for i in `cat $di/.t.txt`
do
j='https://twist.moe'
j=$j$i
echo $j >> $di/list.txt 
done
echo copying download.sh to $di
cp download.sh $di/
echo Done
