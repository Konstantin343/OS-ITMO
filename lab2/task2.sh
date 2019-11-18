#!/bin/bash

log_file="full.log"
warning_flag="\(WW\)"
info_flag="\(II\)"
regex="^\[.+?\].+?(${info_flag}|${warning_flag})"

touch "$log_file"
grep -E "$regex" "/var/log/Xorg.0.log" \
  | sed -E "s/${warning_flag}/Warning/g" \
  | sed -E "s/${info_flag}/Information/g" \
  | sort -k 3 \
  > "$log_file"
cat "$log_file"
