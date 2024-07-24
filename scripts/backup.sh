#!/bin/bash

SOURCE_DIR="/home/app/"
BACKUP_DIR="/home/backup"
BACKUP_FILE="backup_$(date +%Y%m%d%H%M%S).tar.gz"
S3_BUCKET="s3://backup/"
LOG_FILE="/home/backup.log"

echo "Creating backup of $SOURCE_DIR..."
tar -czf "$BACKUP_DIR/$BACKUP_FILE" "$SOURCE_DIR"
if [ $? -ne 0 ]; then
  echo "Backup creation failed!" | tee -a "$LOG_FILE"
  exit 1
fi

echo "Uploading backup to S3..."
s3cmd put "$BACKUP_DIR/$BACKUP_FILE" "$S3_BUCKET"
if [ $? -ne 0 ]; then
  echo "Upload to S3 failed!" | tee -a "$LOG_FILE"
  exit 1
fi

echo "Backup and upload completed successfully!" | tee -a "$LOG_FILE"
