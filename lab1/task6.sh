#!/bin/bash
if [[ "$HOME" == "$PWD" ]]; then 
  echo "$HOME" 
else 
  exit 1
fi
