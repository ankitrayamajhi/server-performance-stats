#!/bin/bash

echo "=== SERVER PERFORMANCE STATS ==="

# OS Version
echo -e "\n>> OS Version:"
cat /etc/os-release | grep PRETTY_NAME

# Uptime
echo -e "\n>> Uptime:"
uptime -p

# CPU Usage
echo -e "\n>> CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "CPU Usage: " 100 - $8 "%"}'

# Memory Usage
echo -e "\n>> Memory Usage:"
free -m | awk 'NR==2{printf "Used: %sMB | Free: %sMB | Usage: %.2f%%\n", $3,$4,$3*100/$2 }'

# Disk Usage
echo -e "\n>> Disk Usage:"
df -h | awk '$NF=="/"{printf "Used: %s | Free: %s | Usage: %s\n", $3,$4,$5}'

# Top 5 CPU processes
echo -e "\n>> Top 5 CPU-consuming processes:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

# Top 5 Memory processes
echo -e "\n>> Top 5 Memory-consuming processes:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6

# Logged-in Users
echo -e "\n>> Logged-in Users:"
who

# Failed Login Attempts
echo -e "\n>> Failed Login Attempts:"
journalctl _COMM=sshd | grep "Failed password" | wc -l
