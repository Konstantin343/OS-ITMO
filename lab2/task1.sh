#!/bin/bash

error_file="errors.log"

touch "$error_file"
grep -rsh "^ACPI" "/var/log" > "$error_file"
grep -E "/.+" "$error_file"
