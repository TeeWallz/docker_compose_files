CONTAINER=
BACKUPFILE=
USERNAME
DBNAME

psql -h localhost -p 54322 --username=root -f $BACKUPFILE $DBNAME
docker exec --tty --interactive $CONTAINER /bin/sh -c "zcat $BACKUPFILE | psql --username=$USERNAME --dbname=$DBNAME -W"