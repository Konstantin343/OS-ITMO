#!/bin/bash

pid_file="sbin_pid.lst"

touch "$pid_file"
ps -eo pid,cmd \
  | grep "/sbin/" \
  | sed "s/^[[:space:]]*//" \
  | cut -d " " -f 1 \
  > "$pid_file"
