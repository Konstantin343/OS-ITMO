#!/bin/bash

file /bin/* \
  | grep -E ".+?:.+?script" \
  | cut -d ":" -f 1 \
  | xargs head -n 1 \
  | sort \
  | uniq -c \
  | sort -k 1 -rn \
  | head -n 1 \
  | grep -o -E "/bin/.+"
