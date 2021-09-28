# syntax=docker/dockerfile:1
FROM ghcr.io/linuxserver/plex
COPY ./data /data
RUN chmod +x /data/backup_plex_config.sh && chmod +x /data/b2-linux
RUN /data/create_cron_for_backup.sh