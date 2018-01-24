name=$1
if [ ! -f animelist.txt ]
then
touch animelist.txt
fi
FILE='animelist.txt'
#doesn't exist in animelist.txt 
if grep -q $name "$FILE" 
then

echo You like this anime?
echo Me too!!
else

echo "$name" >> animelist.txt
#add it
echo $name Added to animelist.txt
fi
IFS=$'\n'
for i in $( ls -1 Anime )
do
if ! grep -q $i "$FILE"
then
#echo You like this anime?
#echo Me too!!
#removed these comments
echo "$i" >> animelist.txt
#add it
echo $i Added to animelist.txt
fi
done
