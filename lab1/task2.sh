#!/bin/bash
max="$1"
for i in $2 $3; do
  if [[ "$i" -gt "$max" ]]; then 
    max="$i"
  fi
done
echo "$max"

