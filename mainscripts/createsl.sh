#!/bin/bash
if [ "$1" == "HHHHFFFFFFSDFSHDFSKDFGDSILGFSDIIMPOSSIBLEPATHOTESFEE" ]; then
  rm /usr/bin/scratchlang
else
  echo >>/usr/bin/scratchlang "cd $1 && python3 scratchlang.py \$1 \$2 \$3"
fi
