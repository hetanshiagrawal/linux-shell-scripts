# Assignment 1: Linux shell scripting and Git

Two Bash scripts for the DevSecCops.ai assignment.

| Script | Purpose |
|---|---|
| `sysinfo.sh` | Prints hostname, date/time, logged-in user, disk usage of `/`, memory usage and the top 5 processes by memory. Also saves output to a file named with today's date. |
| `log_report.sh` | Takes an access log and prints total requests, number of 404 errors and the top 3 IP addresses. Prints a usage message if no file is given. |

## Prerequisites
Linux (or WSL/macOS with GNU coreutils), Bash, and standard tools: `df`, `free`, `ps`, `awk`, `sort`, `uniq`.

## How to run

```bash
git clone <your-repo-url>
cd <repo>
chmod +x sysinfo.sh log_report.sh     # already executable in the repo

./sysinfo.sh                  # saves to ./reports/sysinfo_YYYY-MM-DD.txt
./sysinfo.sh /var/log/mysys   # optional: custom output directory

./log_report.sh sample_access.log
./log_report.sh               # prints usage message and exits with code 1
```

## Sample output

### `./sysinfo.sh`
```
===== System Information =====
Hostname      : vm
Date and time : 2026-11-26 18:14:36 UTC
Logged-in user: root

===== Disk usage of / =====
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda        252G  6.6G   10G  40% /

===== Memory usage =====
               total        used        free      shared  buff/cache   available
Mem:           3.9Gi       181Mi       3.8Gi        12Mi        46Mi       3.7Gi
Swap:             0B          0B          0B

===== Top 5 processes by memory =====
  PID USER     %MEM %CPU COMMAND
   69 root      0.7  8.5 rclone-filestor
    1 root      0.1 26.5 process_api
  106 root      0.0  0.0 ps
   95 root      0.0  0.0 bash
   68 64321     0.0  0.0 7

[saved to ./reports/sysinfo_2026-11-26.txt]
```

### `./log_report.sh sample_access.log`
```
===== Log report for: sample_access.log =====
Total requests : 9
404 errors     : 3
Top 3 IP addresses:
  192.168.1.10     3 requests
  10.0.0.5         3 requests
  172.16.0.8       2 requests
```

### `./log_report.sh` (no argument)
```
Usage: ./log_report.sh <logfile>
Prints total requests, number of 404 errors and the top 3 IP addresses.
```

## Bonus items
- **Usage message** when no file is given (`log_report.sh`); also a clear error for missing/unreadable files.
- **Dated output file**: `sysinfo.sh` appends to `reports/sysinfo_<today>.txt`.
- **Hourly cron** (edit with `crontab -e`, use your absolute path):

```cron
0 * * * * /home/youruser/assignment1/sysinfo.sh /home/youruser/assignment1/reports >/dev/null 2>&1
```

## Notes
- `log_report.sh` assumes Apache/Nginx common or combined log format (IP is field 1, status code is field 9).
