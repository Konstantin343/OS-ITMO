#!/bin/bash

file="data.txt"

touch "${file}"
while true; do
  read line
  echo "${line}" >> "${file}"
done 
