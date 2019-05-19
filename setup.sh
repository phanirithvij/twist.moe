#!/bin/bash
py=false

if command -v python &>/dev/null
then
    echo Python is installed
    py=true
    pyv="$(python -V 2>&1)"
    echo "Version: $pyv"
else
    echo python not accesible from the script
fi
if command -v python3 &>/dev/null
then
    echo Python 3 is installed
    py=true
    pyv="$(python -V 2>&1)"
    echo "Version: $pyv"
    # modify the api.sh file
    sed -i 's/python/python3/g' api.sh
else
    echo python3 command is not accesible from the script
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
        echo 'Installing Crypto for python'
        python -m pip install --user pycryptodome
    fi
    python -c "import hashlib" &>/dev/null
    if [ $? -ne 0 ]
    then
        echo 'Installing hashlib for python'
        python -m pip install --user hashlib
    fi
    echo 'pycryptodome, hashlib for python installed'
fi
