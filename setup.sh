#!/bin/bash
py=false

if command -v python &>/dev/null
then
    echo Python is installed
    py=true
else
    echo Python is not installed
fi
if command -v python3 &>/dev/null
then
    echo Python 3 is installed
    py=true
    # modify the api.sh file
    sed -i 's/python/python3/g' api.sh
else
    echo Python 3 is not installed
fi
if [ ! $py ]
then
    echo 'Python not found'
    echo 'Install using sudo?(Y/n)'
    read installpy
    if [ $installpy == "Y" -o $installpy == "y" -o $installpy == "yes" ]
    then
        sudo apt-get install python python3 python-pip python3-pip
        echo 'Python installed'
    fi
fi
if $py
then
    python -c "import Crypto" &>/dev/null
    if [ $? -ne 0 ]
    then
        echo 'Install Crypto for python'
        sudo pip install pycryptodome
    fi
    python -c "import hashlib" &>/dev/null
    if [ $? -ne 0 ]
    then
        echo 'Install hashlib for python'
        sudo pip install hashlib
    fi
    echo 'Crypto, hashlib for python installed'
fi