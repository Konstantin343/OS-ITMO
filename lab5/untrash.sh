#!/bin/bash

file_name="$1"

function restore {
  ln ~/.trash/$1 $2 2>/dev/null \
    || ln ~/.trash/$1 ~/${file_name} 2>/dev/null
    if test -f $2; then
      echo "Restore $2"
    else 
      echo "Restore ${file_name} in home directory"
    fi
  rm ~/.trash/$1 
}


mapfile list < <(grep "${file_name} [0-9]*" ~/.trash.log)

for line in "${list[@]}"; do
  old_path=$(echo "${line}" | sed 's/^[0-9]* //')
  link=$(echo "${line}" | cut -d " " -f 1)
  if test -f ~/.trash/${link}; then 
    echo "Do you want to restore file '${old_path}'? [Y/N]"
    while read ans; do
      case "${ans}" in
        "Y")
          restore ${link} ${old_path}
          continue 2
        ;;
        "N")
          continue 2
          ;;
        *)
          echo "Usage: Y - confirm, N - decline"
          ;;
      esac
    done
  fi
done
