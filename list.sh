name=$1
if [ ! -f animelist.txt ]
then
touch animelist.txt
FILE='animelist.txt'
fi
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

