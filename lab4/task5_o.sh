#!/bin/bash

file="data.txt"

cur_value=1
cur_op="+"

(tail -n 0 -f "${file}") |
while true; do
  read line
  case "${line}" in
    "QUIT")
      echo "exit 0"
      kill $$
      ;;
    "+")
      cur_op="+"
      ;;
    "*")
      cur_op="*"
      ;;
    [0-9]*)
      let cur_value="${cur_value}${cur_op}${line}"
      echo "${cur_value}"
      ;;
    *)
      echo "exit 1"
      kill $$	
      ;;
  esac
done  
