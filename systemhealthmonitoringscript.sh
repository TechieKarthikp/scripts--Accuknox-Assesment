#!/bin/bash

# Thresholds for alerts
CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=90

# Check CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU usage: $CPU_USAGE%"
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
  echo "Warning: High CPU usage! Current usage: $CPU_USAGE%" >> system_health.log
fi

# Check memory usage
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
echo "Memory usage: $MEM_USAGE%"
if (( $(echo "$MEM_USAGE > $MEM_THRESHOLD" | bc -l) )); then
  echo "Warning: High memory usage! Current usage: $MEM_USAGE%" >> system_health.log
fi

# Check disk space usage
DISK_USAGE=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
echo "Disk usage: $DISK_USAGE%"
if [ $DISK_USAGE -gt $DISK_THRESHOLD ]; then
  echo "Warning: High disk usage! Current usage: $DISK_USAGE%" >> system_health.log
fi

echo "System health check complete!"
