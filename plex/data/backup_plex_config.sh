#!/bin/bash

# Plex Database Location. The trailing slash is 
# needed and important for rsync.
plexDatabase="/opt/PlexLibrary/Library/Application Support/Plex Media Server"

# Location to backup the directory to.
backupDirectory="/tmp/"

# Log file for script's output named with 
# the script's name, date, and time of execution.
scriptName=$(basename ${0})
log="/tmp/plex_backup.log"

# Check for root permissions
if [[ $EUID -ne 0 ]]; then
echo -e "${scriptName} requires root privileges.\n"
echo -e "sudo $0 $*\n"
exit 1
fi

# Create Log
echo -e "***********" >> $log 2>&1

# Stop Plex
echo -e "$(date '+%Y-%b-%d at %k:%M:%S') :: Stopping Plex Media Server." | tee -a $log 2>&1
sudo service plexmediaserver stop | tee -a $log 2>&1

# Backup database
echo -e "$(date '+%Y-%b-%d at %k:%M:%S') :: Starting Backup." | tee -a $log 2>&1
cd "$plexDatabase"
sudo tar cz --exclude='./Cache' -f "$backupDirectory/plex-backup.tar.gz" . >> $log 2>&1

# Restart Plex
echo -e "$(date '+%Y-%b-%d at %k:%M:%S') :: Starting Plex Media Server." | tee -a $log 2>&1
sudo service plexmediaserver start | tee -a $log 2>&1

#Push backup to B2
echo -e "$(date '+%Y-%b-%d at %k:%M:%S') :: Pushing backup to B2." | tee -a $log 2>&1
./b2-linux authorize-account ${ACCOUNT_ID} ${ACCOUNT_KEY}
./b2-linux upload-file TomConfigBackups "$backupDirectory/plex-backup.tar.gz" plex/plex-backup.tar.gz

# Done
echo -e "$(date '+%Y-%b-%d at %k:%M:%S') :: Backup Complete." | tee -a $log 2>&1
echo -e "***********" >> $log 2>&1
