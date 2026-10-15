#!/bin/bash
DISK_THRESHOLD=90 #percent
MEM_THRESHOLD=90 #percent

echo "========================================"
echo "   SYSTEM HEALTH CHECK"
echo "   $(date)"
echo "========================================"

echo ""
echo "--- Disk Usage ---"
df -h --output=target,size,used,avail,pcent | grep -E '^/'

echo ""
echo "--- Memory Usage ---"
free -h

echo ""
echo "--- CPU Load ---"
uptime

echo ""
echo "--- Top 5 Processes by CPU ---"
ps aux --sort=-%cpu | head -6

echo ""
echo "--- Top 5 Processes by Memory ---"
ps aux --sort=-%mem | head -6

echo ""
echo "--- Logged In Users ---"
who

echo ""
echo "========================================"
echo "   ALERTS"
echo "========================================"

ALERT_FOUND=0

# Check disk usage on root partition
DISK_USAGE=$(df --output=pcent / | tail -1 | tr -dc '0-9')
if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    echo "🚨 WARNING: Disk usage on / is at ${DISK_USAGE}% (threshold: ${DISK_THRESHOLD}%)"
    ALERT_FOUND=1
fi

# Check memory usage
MEM_USAGE=$(free | grep Mem | awk '{printf "%.0f", $3/$2 * 100}')
if [ "$MEM_USAGE" -ge "$MEM_THRESHOLD" ]; then
    echo "🚨 WARNING: Memory usage is at ${MEM_USAGE}% (threshold: ${MEM_THRESHOLD}%)"
    ALERT_FOUND=1
fi

if [ "$ALERT_FOUND" -eq 0 ]; then
    echo "✅ No issues detected. All systems within normal thresholds."
fi

echo ""
echo "========================================"
echo "   Health check complete"
echo "========================================"
