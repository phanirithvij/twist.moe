#!/bin/bash
xargs -0 -n 1 ./startp.sh < <(tr \\n \\0 <animelist.txt)
