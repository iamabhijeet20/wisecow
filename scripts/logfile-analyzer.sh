#!/bin/bash

LOG_FILE="/var/log/apache2/access.log"

if [ ! -f "$LOG_FILE" ]; then
    echo "File not found: $LOG_FILE"
    exit 1
fi

echo "Analyzing log file: $LOG_FILE"

echo "Total 404 Errors:"
grep '" 404 ' "$LOG_FILE" | wc -l

echo -e "\nMost Requested Pages:"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 10

echo -e "\nIP Addresses with Most Requests:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -n 10
