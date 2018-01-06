IFS=$'\n'
l=`cat list.txt | wc -l`
echo Total no of episodes : $l
echo start at:
read s
echo end at:
read e
j=1
for i in `cat list.txt`
do
	if [ $j -ge $s -a $j -le $e ]
	then
		wget -q --show-progress $i
	fi
	j=$((j+1))
done
