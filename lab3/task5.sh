#!/bin/bash

avg_time_file="avg_time.lst"

function get_field {
  grep -i "^$1" $2 \
    | cut -d ":" -f 2 \
    | awk '{print $1}'
}

touch "$avg_time_file"
for proc in /proc/[0-9]*; do
  pid=$(get_field "pid" "${proc}/status")
  ppid=$(get_field "ppid" "${proc}/status")
  sleep_avg=$(get_field "avg_atom" "${proc}/sched"); 
  echo "${pid} ${ppid} ${sleep_avg}"
done \
  | sort -n -k 2 \
  | awk '{print "ProcessID=" $1 " : Parent_ProcessID=" $2 " : Average_Sleeping_Time=" $3}' \
  > "$avg_time_file"
  
