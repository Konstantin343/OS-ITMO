#!/bin/bash

diff_file="mem_diff.lst"

function get_mem_diff {
  awk '{print $2-$3}' $1/statm
}

function get_pid {
  echo "$1" | sed "s/\/proc\///"
}

touch "$diff_file"
for proc in /proc/[0-9]*; do
  pid=$(get_pid $proc)
  let mem_diff=$(get_mem_diff "$proc")*4
  echo "${pid} ${mem_diff}KB";
done \
  | sort -rnk2 \
  | tr " " ":" \
  > "$diff_file"
