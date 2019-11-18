#!/bin/bash

function get_date {
  echo "$1" | sed 's/Backup-//g'
}

function seconds {
  date --date="$(get_date $1)" +%s
}

function find_backups {
ls -l ~/ \
  | grep "^d" \
  | cut -d ' ' -f 9 \
  | grep -E "^Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}$"
}

mapfile list < <(find_backups)
latest=""
time=0
for bu in "${list[@]}"; do
  bu=$(echo ${bu} | sed 's/\n//g')
  bu_time="$(seconds ${bu})"
  if [[ "${bu_time}" -gt "${time}" ]]; then
    time="${bu_time}"
    latest="${bu}"
  fi
done

if [[ "${latest}" == "" ]]; then
  echo "No backups"
  exit 1
fi

mapfile sources < <(ls ~/${latest} | grep -v -E "^.*\.[0-9]{4}-[0-9]{2}-[0-9]{2}$")
for file in "${sources[@]}"; do
  file=$(echo ${file} | sed 's/\n//g')
  cp ~/${latest}/${file} ~/restore/
done
