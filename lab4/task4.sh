#!/bin/bash

inf="./inf_loop.bash"

nice -n 8 "${inf}" &
"${inf}" &
