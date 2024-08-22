#!/bin/bash

# Function to display top 10 CPU and Memory consuming applications
show_top_applications() {
    echo "Top 10 CPU-consuming applications:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 11
    echo ""
    echo "Top 10 Memory-consuming applications:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 11
}

# Function to monitor network
show_network_monitoring() {
    echo "Network Monitoring:"
    echo "Number of concurrent connections:"
    netstat -an | grep ESTABLISHED | wc -l
    echo ""
    echo "Packet drops:"
    netstat -s | grep "packet receive errors"
    echo ""
    echo "Network traffic (MB in and out):"
    ifconfig | awk '/RX bytes/ {print "Received: " $2/1048576 " MB"} /TX bytes/ {print "Transmitted: " $6/1048576 " MB"}'
}

# Function to display disk usage
show_disk_usage() {
    echo "Disk Usage:"
    df -h | awk ' $5 > 80'
}

# Function to show system load
show_system_load() {
    echo "System Load:"
    uptime
    echo ""
    echo "CPU Usage Breakdown:"
    mpstat
}

# Function to display memory usage
show_memory_usage() {
    echo "Memory Usage:"
    free -h
    echo ""
    echo "Swap Memory Usage:"
    free -h | grep "Swap"
}

# Function to monitor processes
show_process_monitoring() {
    echo "Process Monitoring:"
    echo "Number of active processes:"
    ps -e | wc -l
    echo ""
    echo "Top 5 CPU-consuming processes:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
    echo ""
    echo "Top 5 Memory-consuming processes:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}

# Function to monitor essential services
show_service_monitoring() {
    echo "Service Monitoring:"
    services=(sshd nginx apache2 iptables)
    for service in "${services[@]}"; do
        if systemctl is-active --quiet "$service"; then
            echo "$service is running"
        else
            echo "$service is not running"
        fi
    done
}

# Main Dashboard function
show_dashboard() {
    echo "System Dashboard:"
    echo "--------------------"
    show_top_applications
    echo "--------------------"
    show_network_monitoring
    echo "--------------------"
    show_disk_usage
    echo "--------------------"
    show_system_load
    echo "--------------------"
    show_memory_usage
    echo "--------------------"
    show_process_monitoring
    echo "--------------------"
    show_service_monitoring
}

# Refresh interval in seconds
REFRESH_INTERVAL=5

# Check for command-line switches
while getopts ":a:n:d:l:m:p:s" opt; do
    case $opt in
        a) show_top_applications ;;
        n) show_network_monitoring ;;
        d) show_disk_usage ;;
        l) show_system_load ;;
        m) show_memory_usage ;;
        p) show_process_monitoring ;;
        s) show_service_monitoring ;;
        *) echo "Invalid option: -$OPTARG" >&2 ;;
    esac
    exit 0
done

# If no switches, run the dashboard in a loop
while true; do
    clear
    show_dashboard
    sleep "$REFRESH_INTERVAL"
done
