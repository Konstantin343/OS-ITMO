#!/bin/bash

cat "/etc/passwd" \
  | cut -d ":" -f "1 3" \
  | tr ":" " " \
  | sort -nk 2
