#!/usr/bin/env bash

# Based on:
# https://docs.immich.app/administration/backup-and-restore/#manual-backup-and-restore
# https://torsion.org/borgmatic/how-to/extract-a-backup/

rm -rf $DB_DATA_LOCATION # CAUTION! Deletes all Immich data to start from scratch
docker rm immich_machine_learning
docker volume rm $VOLUME_NAME
borgmatic extract --archive latest --destination $RESTORE_DESTINATION_PATH
docker start immich_postgres
sleep 10
gunzip --stdout "$RESTORE_DESTINATION_PATH/dump.sql.gz" \
| sed "s/SELECT pg_catalog.set_config('search_path', '', false);/SELECT pg_catalog.set_config('search_path', 'public, pg_catalog', true);/g" \
| docker exec -i immich_postgres psql --dbname=postgres --username=$DB_USERNAME

# Start rest of Immich apps
