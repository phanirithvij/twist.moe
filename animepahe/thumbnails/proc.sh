#POSTERIMAGES 

for i in $(cat ../paheslugs.txt| cut -d "	" -f1)
do
	#get all the anime poster images 
	echo $i
	#get id by ../id.sh	
	id=$(../id.sh $i)
	[[ $id == '' ]] && echo $i >> missing.txt
done


#EPISODETHUMBS TAKES LONG TIME


# for  ..................
