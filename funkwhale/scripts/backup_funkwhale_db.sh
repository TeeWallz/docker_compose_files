#!/bin/bash

# Source:
# https://docs.funkwhale.audio/admin/migration.html

# Prerequisite: connect_onedrive has been run

# Run on host

FILENAME=funkwhale_db_backup
cd /tmp

docker exec -t funkwhale pg_dumpall -c -U funkwhale > $FILENAME.dump
tar -czvf $FILENAME.tar.gz $FILENAME.dump
rclone copy $FILENAME.tar.gz onedrive:/OnlineServices/funkwhale/ -q --checksum --drive-chunk-size=64M
rm /tmp/$FILENAME.dump
rm /tmp/$FILENAME.tar.gz