IFS=$'\n'
file=$1
if [ $# -ne 1 ]
then
file=index.html
fi
cat $file | grep "series-title" | cut -d "\"" -f2,6 | tr "\"" "\t" | sed 's/\/a\///g' > twlist.txt
