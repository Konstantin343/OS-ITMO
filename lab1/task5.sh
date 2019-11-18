#!/bin/bash
while true; do
  echo "Menu:"
  echo "1 - nano"
  echo "2 - vim"
  echo "3 - links"
  echo "4 - close menu"
  read command
  case "$command" in
  1)
    nano
    ;;
  2)
    vi
    ;;
  3)
    links
    ;;
  4) 
    exit 0
    ;;
  esac
done
