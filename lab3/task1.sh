#!/bin/bash

procs="procs.lst"

touch "$procs"
ps -U "user" -o pid,comm \
  | tail -n +2 \
  | sed "s/^[[:space:]]*//" \
  | tr " " ":" \
  > "$procs"
cat "$procs" \
  | wc -l
