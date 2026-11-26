#!/usr/bin/env bash
# log_report.sh - summarises a web server access log (Apache/Nginx common log format).
# Usage: ./log_report.sh <logfile>

usage() {
  echo "Usage: $0 <logfile>"
  echo "Prints total requests, number of 404 errors and the top 3 IP addresses."
}

if [ $# -lt 1 ]; then
  usage
  exit 1
fi

LOG="$1"
if [ ! -f "$LOG" ] || [ ! -r "$LOG" ]; then
  echo "Error: '$LOG' does not exist or is not readable." >&2
  usage
  exit 2
fi

total=$(wc -l < "$LOG")
# Status code is the 9th whitespace-separated field in common/combined log format
errors_404=$(awk '$9 == 404' "$LOG" | wc -l)

echo "===== Log report for: $LOG ====="
echo "Total requests : $total"
echo "404 errors     : $errors_404"
echo "Top 3 IP addresses:"
awk '{print $1}' "$LOG" | sort | uniq -c | sort -rn | head -n 3 \
  | awk '{printf "  %-16s %s requests\n", $2, $1}'
