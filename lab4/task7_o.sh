#!/bin/bash

echo $$ > .pid
cur=1
cur_op="+"

function op { 
  let cur="${cur}$1$2"
}

function sigterm {
  echo "Stopped by SIGTERM"
  exit
}

trap 'cur_op="+"' USR1
trap 'cur_op="*"' USR2
trap 'sigterm' SIGTERM
while true; do
  echo "${cur}"
  op "${cur_op}" 2
  sleep 1
done

