#!/bin/bash

emails_file="emails.lst"
regex="[0-9a-zA-Z_-]+@[0-9a-zA-Z_-]+\.[a-zA-Z]+"

touch "$emails_file"
grep -rasho -E "$regex" "/etc" \
  | sort -u \
  | tr "\n" "," \
  > "$emails_file"
