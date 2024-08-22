# systemmonitoringscript
This Bash script provides a real-time monitoring dashboard for various system resources. It offers insights into CPU and memory usage, network activity, disk usage, system load, and more. The script refreshes every few seconds, presenting the data in an easy-to-read dashboard format.

# Function to display top 10 CPU and Memory consuming applications
show_top_applications() 
# Function to monitor network
show_network_monitoring() 
# Function to display disk usage
show_disk_usage()
# Function to show system load
show_system_load()
# Function to display memory usage
show_memory_usage()
# Function to monitor processes
show_process_monitoring()
# Function to monitor essential services
show_service_monitoring()
# Main Dashboard function
show_dashboard() 
# To run the full dashboard with all the features listed above, simply execute the script without any command-line switches:
./monitor_dashboard.sh
# To run specific command
./monitor_dashboard.sh -a
It will print the top 10 cpu consuming 
