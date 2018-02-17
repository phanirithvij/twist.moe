IFS=$'\n'
file=$1
if [ $# -ne 1 ]
then
file=index.html
fi
cat $file | grep "data-title" > tempahref.txt
echo -n '' > twlist.txt
for i in $(cat tempahref.txt)
do
	if [[ $i == *"data-alt"* ]]
	then
		link=$(echo $i | awk -F\" '{print $2}' | cut -d "/" -f3)
		titles=$(echo $i | awk -F\" '{print $6"||"$8}')
		echo $link"||"$titles >> twlist.txt
	else
		link=$(echo $i | awk -F\" '{print $2}' | cut -d "/" -f3)
		titles=$(echo $i | awk -F\" '{print $6}')
		echo $link"||"$titles"||false" >> twlist.txt
	fi
done
rm tempahref.txt
