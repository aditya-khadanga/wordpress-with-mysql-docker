#!/bin/bash

timestamp=$(date +"%Y%m%d_%H%M%S")

echo "[INFO] Starting backup at $timestamp..."

# Backup WordPress files
docker run --rm \
  -v wordpress-docker_wp_data:/data \
  -v $(pwd):/backup \
  alpine tar czf /backup/wp_data_$timestamp.tar.gz -C /data .

# Backup MySQL database
docker exec mysql_db \
  sh -c 'exec mysqldump -u wp_user -p"wp_pass" wordpress' \
  > db_backup_$timestamp.sql

echo "[INFO] Backup completed: wp_data_$timestamp.tar.gz, db_backup_$timestamp.sql"

