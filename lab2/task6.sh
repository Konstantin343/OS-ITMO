#!/bin/bash

find /var/log/ 2>/dev/null \
  | grep -E ".+\.log" \
  | xargs cat 2>/dev/null \
  | wc -l 
