#!/bin/bash
#Script server-stats.sh that can analyse basic server performance stats and gives you the following stats:
#1-Total CPU usage

#!/bin/bash

echo "CPU Usage"
top -bn1 | grep "Cpu(s)" | \
    sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \
    awk '{print "Total CPU Usage: " (100 - $1)"%"}'


#2-Total memory usage (Free vs Used including percentage)
free -h | awk '/^Mem:/ {print "Total Memory: " $2 ", Used: " $3 ", Free: " $4 ", Usage: " $3/$2 * 100 "%"}'

#3-Total disk usage (Free vs Used including percentage)
df -h --total | awk '/^total/ {print "Total Disk Space: " $2 ", Used: " $3 ", Free: " $4 ", Usage: " $5}'

#4-Top 5 processes by CPU usage
echo "==Top 5 Processes by CPU Usage"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6   

#5-Top 5 processes by memory usage
echo "====Top 5 Processes by Memory Usage===
ps -eo pid,comm,%mem --sort=-%mem | head -n 6 
#6- OS  version, uptime, load average, logged in users, failed login attempts.
echo "====System Information===="
echo "OS Version: $(cat /etc/os-release | grep PRETTY_NAME | cut -d '=' -f2 | tr -d '\"')"
echo "Uptime: $(uptime -p)"
echo "Load Average: $(uptime | awk -F'load average:' '{ print $2 }')"
echo "Logged in Users: $(who | wc -l)"
echo "Failed Login Attempts in last 24 hours:"
lastb -s -1days | wc -l


