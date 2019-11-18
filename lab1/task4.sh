#!/bin/bash
n=1
while [[ n%2 -ne 0 ]]; do
  read n
  let cnt=cnt+1
done
echo "$cnt"
