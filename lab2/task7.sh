#!/bin/bash

man bash \
  | grep -o -E "[a-zA-Z]{4}[a-zA-Z]*" \
  | sort \
  | uniq -ic \
  | sort -rn -k 1 \
  | head -n 3 \
  | grep -o -E "[a-z]+"
