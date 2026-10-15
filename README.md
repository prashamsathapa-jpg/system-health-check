# System Health Check (Bash)

A Bash script that checks a Linux system's disk usage, memory usage, CPU load, and top resource-consuming processes, then automatically flags issues against configurable thresholds.

## What it does

- Reports disk usage, memory usage, CPU load average, top 5 processes by CPU and memory, and currently logged-in users
- Compares disk and memory usage against configurable thresholds (default: 90%)
- Prints clear warnings when thresholds are exceeded, or confirms all systems are normal

## Why thresholds matter, not just raw display

A script that only prints numbers requires a human to notice a problem. This script actively evaluates the data against defined limits and raises an alert automatically — the same basic principle behind monitoring/alerting tools used in real system administration and SOC environments (compare to threshold-based alerting in a SIEM).

## Real-world test

This script was tested on a live Ubuntu VM and correctly identified a genuine disk space issue (95% usage on the root partition), which led to real troubleshooting — not just simulated test data.

## Tech stack

- Bash
- Core Linux utilities: `df`, `free`, `uptime`, `ps`, `who`

## Setup

```bash
git clone https://github.com/prashamsathapa-jpg/system-health-check.git
cd system-health-check
chmod +x health_check.sh
./health_check.sh
```

## Sample output
SYSTEM HEALTH CHECK
Thu Oct 15 21:40:03 CEST 2026

--- Disk Usage ---
/run 392M 1.8M 390M 1%
/ 25G 22G 1.3G 95%
/dev/shm 2.0G 0 2.0G 0%

--- Memory Usage ---
total used free shared buff/cache available
Mem: 3.8Gi 1.0Gi 669Mi 29Mi 2.4Gi 2.8Gi
Swap: 3.8Gi 0B 3.8Gi

--- CPU Load ---
21:40:03 up 14 min, 2 users, load average: 0.03, 0.19, 0.26

--- Top 5 Processes by CPU ---
USER PID %CPU %MEM VSZ RSS TTY STAT START TIME COMMAND
prashamsa 1958 2.7 9.3 3919356 375900 ? Ssl 21:26 0:21 /usr/bin/gnome-shell
root 1 0.6 0.3 23324 14752 ? Ss 21:25 0:05 /sbin/init splash

--- Logged In Users ---
prashamsa pts/1 2026-10-15 21:32 (10.0.2.2)

========================================
ALERTS

🚨 WARNING: Disk usage on / is at 95% (threshold: 90%)

========================================
Health check complete

## Concepts demonstrated

- Shell scripting fundamentals (variables, conditionals, command substitution)
- System monitoring using core Linux utilities
- Threshold-based alerting logic
- Practical troubleshooting of a real system issue surfaced by the script itself

## Planned improvements

- [ ] Log results to a timestamped file for tracking trends over time
- [ ] Add email/notification alerting instead of just console output
- [ ] Make thresholds configurable via command-line arguments

## Disclaimer

Built as a learning project to practice Bash scripting and basic system monitoring concepts.
