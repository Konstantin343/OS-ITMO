#!/bin/bash

echo $$ > .pid
cur=1 

function sigterm {
  echo "Stopped by SIGTERM"
  exit  
}

trap 'sigterm' SIGTERM
while true; do
  echo "${cur}"
  let cur="${cur}"+1
  sleep 1
done
