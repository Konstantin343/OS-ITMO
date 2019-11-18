#!/bin/bash

file_name="$1"
trash_dir=".trash"

function get_number {
  if ! test -f ~/.number; then
    cur=0
  else   
    cur=$(cat ~/.number)
  fi
  let new=${cur}+1
  echo "${new}" > ~/.number
  echo "${cur}"
}

if [[ "${file_name}" == "rmtrash" ]]; then
  echo "You can't delete rmtrash script"
  exit 1
fi

if [[ "${file_name}" == "untrash" ]]; then
  echo "You can't delete untrash script"
  exit 1
fi

if ! test -f ./${file_name}; then
  echo "File ${file_name} doesn't exist"
  exit 1
fi

if ! test -d ~/${trash_dir}; then
  mkdir ~/${trash_dir}
fi

link_name="$(get_number)"
ln "${file_name}" ~/${trash_dir}/${link_name}
rm "${file_name}"

echo "${link_name} ${PWD}/${file_name}" >> ~/.trash.log
