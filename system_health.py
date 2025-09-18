import psutil
import logging
from datetime import datetime

# Configure logging
logging.basicConfig(filename='system_health.log', level=logging.INFO, format='%(asctime)s - %(message)s')

# Thresholds
CPU_THRESHOLD = 80
MEMORY_THRESHOLD = 80
DISK_THRESHOLD = 80

def check_cpu():
    usage = psutil.cpu_percent(interval=1)
    if usage > CPU_THRESHOLD:
        logging.warning(f"High CPU usage detected: {usage}%")
    return usage

def check_memory():
    memory = psutil.virtual_memory()
    usage = memory.percent
    if usage > MEMORY_THRESHOLD:
        logging.warning(f"High Memory usage detected: {usage}%")
    return usage

def check_disk():
    disk = psutil.disk_usage('/')
    usage = disk.percent
    if usage > DISK_THRESHOLD:
        logging.warning(f"High Disk usage detected: {usage}%")
    return usage

def main():
    cpu = check_cpu()
    mem = check_memory()
    disk = check_disk()
    print(f"CPU Usage: {cpu}% | Memory Usage: {mem}% | Disk Usage: {disk}%")

if __name__ == "__main__":
    main()
