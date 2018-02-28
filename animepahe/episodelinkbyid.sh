#OUTPUTS DIRECT VIDEO LINK FROM NODEFILE EMBED LINKS 
#EXAMPLE
#for episodelinkbyid.sh 40301
#	https://d2.nodefiles.com/files/2/ZsjQCLSLFQcOjzeYc9CDL1PxiWjSUU805IEMZeOnaEs90vGCnI78cjcyWqWsLa9W/video.mp4 "720p" "filesize":123696599
#	https://d2.nodefiles.com/files/4/p_oq6YBqQOQzqVrAE8ldNMFUlpZ7sp5xaVdguLZZTbgFHV-7v698mu4GsfbNEnXE/video.mp4 "1080p" "filesize":212193956

id=$1
#wget -O vid1.json "https://animepahe.com/api?m=link&id=$id&p=nodefiles"
wget -q -O vid.json "https://animepahe.com/api?m=embed&id=$id&p=NodeFiles"
#cat vid1.json vid2.json > vid.json
#rm vid1.json vid2.json
cat vid.json | sed 's/{/{\n/g' | sed 's/},/\n},\n/g' | sed 's/}[^,]/\n}/g' | sed 's/,/,\n/g' > vidindent.json
#links=$(cat vidindent.json | grep 'url' | tr ',' '\0')
links=$(cat vidindent.json | grep 'url' | tr ',' '\0' | cut -d "\"" -f2,4 | cut -d "\"" -f2)
#echo -e $links
quals=$(cat vidindent.json | grep -E '.p"')
sizes=$(cat vidindent.json | grep -E 'filesize')
IFS=$'\n'
rm -f links.txt sizes.txt quals.txt
for i in $links
do
link=$(echo $i | sed 's/\\/ /g' | tr -d ' ' )
wget -q -O node.html $link
#echo tr $(echo $i | tr '\' '5')
cat node.html | grep 'eval(function'| tr '>' '\n' | grep -E '^eval' > tempvid.js
echo url = \'\'\; > tempnode.js
cat tempvid.js | sed 's/return/url+=/g' >> tempnode.js
echo console.log\(url\)\; >> tempnode.js
node tempnode.js | cut -d "\"" -f4 >> links.txt
done
for i in $sizes
do
	echo $(echo $i|tr -d ',') >> sizes.txt
done
for i in $quals
do
	echo $(echo $i | cut -d ":" -f1) >> quals.txt
done
paste -d ' ' links.txt quals.txt sizes.txt
