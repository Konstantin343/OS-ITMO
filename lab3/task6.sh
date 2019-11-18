#!/bin/bash

avg_time_file="avg_time.lst"
temp_file="temp"

function get_field {
  echo "$2" \
    | cut -d ":" -f $1 \
    | cut -d "=" -f 2 \
    | sed "s/[[:space:]]//g"
}

function get_with_zero {
  if (( $(echo "$1 < 1" | bc -l) )); then
    echo "0$1"
  fi
}

function get_result {
  avg=$(bc <<< "scale=6; ${sum_cur}/${cnt_cur}")
  echo "Average_Sleeping_Children_of_Parent=$ppid_last is $(get_with_zero $avg)"
}

touch "$temp_file"
ppid_last=0
cnt_cur=0.0
sum_cur=0.0

while read line; do
  ppid_cur=$(get_field 2 "$line")
  if [[ "$ppid_cur" -ne "$ppid_last" ]]; then
    get_result 
    sum_cur=0.0
    cnt_cur=0.0
  fi
  sum_cur=$(bc <<< $sum_cur+$(get_field 3 "$line"))
  cnt_cur=$(bc <<< $cnt_cur+1.0)
  echo "$line"
  ppid_last="$ppid_cur"
done < "$avg_time_file" > "$temp_file"

get_result >> "$temp_file"
cat "$temp_file" > "$avg_time_file"
rm "$temp_file"
