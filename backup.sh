#!/bin/bash

# Variables
SOURCE_DIR="/mnt/d/Devops/wisecow/data"
BACKUP_DIR="/mnt/d/Devops/wisecow/backups"
LOG_FILE="/mnt/d/Devops/wisecow/backup.log"

# Create timestamped backup folder
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
DEST="$BACKUP_DIR/backup_$TIMESTAMP"

mkdir -p "$DEST"

# Copy files
cp -r "$SOURCE_DIR"/* "$DEST"

# Check if copy succeeded
if [ $? -eq 0 ]; then
    echo "$(date) - Backup Successful to $DEST" | tee -a $LOG_FILE
else
    echo "$(date) - Backup Failed" | tee -a $LOG_FILE
fi
