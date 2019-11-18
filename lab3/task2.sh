#!/bin/bash

ps -eo pid,lstart \
  | tail -n 1
