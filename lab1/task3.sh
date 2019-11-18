#!/bin/bash
while [[ "$cur" != "q" ]]; do 
  res="$res $cur"
  read cur
done
echo "$res"
 
