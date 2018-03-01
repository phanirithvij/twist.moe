DO THIS FOR GETTING SIZES

for i in $(cat Anime/bleach/list.txt)
do
x=$(wget $i --spider --server-response -O - 2>&1 | grep -E '^Length'|cut -d " " -f3 | tr ")" "\0" | tr "(" "\0"  )
echo "$i $x"
done
