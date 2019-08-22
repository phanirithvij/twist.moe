#!/bin/bash
py=false

if command -v python &>/dev/null
then
    echo "[setup.sh] > Python is installed"
    py=true
    pyv="$(python -V 2>&1)"
    echo "[setup.sh] > Version: $pyv"
else
    echo "[setup.sh] > python not accesible from the script"
fi
if command -v python3 &>/dev/null
then
    echo "[setup.sh] > Python 3 is installed"
    py=true
    pyv="$(python3 -V 2>&1)"
    echo "[setup.sh] > Version: $pyv"
    # modify the api.sh file
    if [ -f ".setup_done" ]
    then
        echo "[setup.py] > Setup already done"
        echo "[setup.py] > remove .setup_done file and run this again if need to force setup"
    else
        python setup.py
        touch .setup_done
    fi
else
    echo "[setup.sh] > python3 command is not accesible from the script"
fi
if [ ! $py ]
then
    echo '[setup.sh] > Python not found'
    echo '[setup.sh] > Install using sudo?(Y/n)'
    read installpy
    if [ $installpy == "Y" -o $installpy == "y" -o $installpy == "yes" ]
    then
        echo sudo apt-get install python3 python3-pip
        sudo apt-get install python3 python3-pip
        echo '[setup.sh] > Python is installed'
    else
        echo "[setup.sh] > Please install python3"
    fi
fi
if $py
then
    python -c "import Cryptodome" &>/dev/null
    if [ $? -ne 0 ]
    then
        echo '[setup.sh] > Installing Crypto for python'
        python -m pip install --user pycryptodomex
    fi
    python -c "import hashlib" &>/dev/null
    if [ $? -ne 0 ]
    then
        echo '[setup.sh] > Installing hashlib for python'
        python -m pip install --user hashlib
    fi
    echo '[setup.sh] > pycryptodomex, hashlib for python installed'
fi
