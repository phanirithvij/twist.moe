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
for i in $(cat list.txt | awk '{print $1}')
do
wget -c -q --show-progress $i
done
else
j=1
for i in $(cat list.txt)
do
	if [ $j -ge $s -a $j -le $e ]
	then
		wget -c -q --show-progress $i
	fi
	j=$((j+1))
done
fi
