#!/bin/bash

function days_diff {
  echo $(( ($(date --date="$1" +%s) - $(date --date="$2" +%s)) / (60 * 60 * 24) ))
}

function find_backups {
ls -l ~/ \
  | grep "^d" \
  | cut -d ' ' -f 9 \
  | grep -E "^Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}$"
}

function get_date {
  echo "$1" | sed 's/Backup-//g'
}

function get_size {
  stat --format=%s $1
}

now=$(date '+%Y-%m-%d')
mapfile list < <(find_backups)

for bu in "${list[@]}"; do
  bu=$(echo ${bu} | sed 's/\n//g')
  bu_date=$(get_date "${bu}")
  if [[ $(days_diff "${now}" "${bu_date}") -lt 7 ]]; then
    echo "[$(date)] Use old backup catalog: ~/${bu}" \
      >> ~/backup-report

    for file in "${sources[@]}"; do
      file=$(echo ${file} | sed 's/\n//g')
      if ! test -f ~/${bu}/${file}; then
        cp ~/source/${file} ~/${bu}/
        echo "${file}" >> ~/backup-report 
      elif [[ $(get_size ~/source/${file}) -ne $(get_size ~/${bu}/${file}) ]]; then
        old="${file}.${now}"
        mv ~/${bu}/${file} ~/${bu}/${old}
        cp ~/source/${file} ~/${bu}/
        echo "${file}, old: ${old}" >> ~/backup-report
      fi
    done
    exit 0 
  fi 
done

bu_name="Backup-${now}"
mkdir ~/${bu_name}
cp ~/source/* ~/${bu_name}
echo "[$(date)] Created new backup catalog: ~/${bu_name}" \
  >> ~/backup-report
ls ~/${bu_name} >> ~/backup-report
 
