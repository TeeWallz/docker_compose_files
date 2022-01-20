
# Shell into
    docker exec -it postgres_pg_backup_s3_1 bash


# Backup
    docker exec postgres_pg_backup_s3_1 sh backup.sh

# Restore
    docker exec postgres_pg_backup_s3_1 sh restore.sh