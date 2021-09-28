#!/bin/bash

# Tell cron to run backup to B2 Weekly, Sunday Midnight
TEMP_CRON_FILE=/tmp/mycron
# Write out current crontab
crontab -l > ${TEMP_CRON_FILE}
# Echo new cron into cron file
echo "0 0 * * 0 root /data/backup_plex_config.sh" >> ${TEMP_CRON_FILE}
# Install new cron file
crontab ${TEMP_CRON_FILE}
rm ${TEMP_CRON_FILE}
