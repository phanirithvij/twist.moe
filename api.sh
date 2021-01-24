#!/bin/bash
IFS=$'\n'

slug=$1
api_url="https://api.twist.moe/api/anime/${slug}/sources"

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Windows;;
    MINGW*)     machine=Windows;;
    MSYS*)      machine=Windows;;
    *)          machine="UNKNOWN:${unameOut}"
esac

python3x="py -3"
if [[ $machine != "Windows" ]]; then
    if command -v python3 &>/dev/null; then
        python3x="python3"
    else
        python3x="python"
    fi
fi

X_ACCESS_TOKEN=$(eval "$python3x -c \"from x_access_token import X_ACCESS_TOKEN;print(X_ACCESS_TOKEN)\"")
json=$(curl -s "${api_url}" -H "x-access-token: $X_ACCESS_TOKEN")
rm -f .temp.txt
for data in $(echo $json | eval "$python3x jsonP.py")
do
    echo $data >> .temp.txt
done

eval "$python3x decrypt.py .temp.txt file > .data.txt"
cat .data.txt
