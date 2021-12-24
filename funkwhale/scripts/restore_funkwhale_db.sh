#!/bin/bash

# Source:
# https://docs.funkwhale.audio/admin/migration.html

FILENAME=funkwhale_db_backup
cd /tmp

rclone copy onedrive:/OnlineServices/funkwhale/$FILENAME.tar.gz . -q --checksum --drive-chunk-size=64M
tar -xf $FILENAME.tar.gz

docker exec -t funkwhale pg_restore -c -U funkwhale -d postgres < /tmp/$FILENAME.dump
