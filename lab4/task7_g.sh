#!/bin/bash

function signal {
  kill $1 $(cat .pid)
}

while true; do
  read line
  case "${line}" in
    "+")
      signal "-USR1"
      ;;
    "*")
      signal "-USR2"
      ;;
    "TERM")
      signal "-SIGTERM"
      ;;
    *)
      :
      ;;
  esac
done
