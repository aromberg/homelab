#!/bin/bash
set -euo pipefail

RESTIC_REPOSITORY_FILE="/mnt/data/paperless/backup/restic-repo"
RESTIC_PASSWORD_FILE="/mnt/data/paperless/backup/restic-password"
AWS_ENV_FILE="/mnt/data/paperless/backup/restic-aws.env"
EXPORT_PATH="/mnt/data/paperless/export"

# Load AWS credentials
set -a
source "$AWS_ENV_FILE"
set +a

export RESTIC_REPOSITORY="$(cat "$RESTIC_REPOSITORY_FILE")"
export RESTIC_PASSWORD="$(cat "$RESTIC_PASSWORD_FILE")"

# Trigger paperless document export
docker exec paperless-webserver-1 \
    python3 /usr/src/paperless/src/manage.py document_exporter \
        --delete /usr/src/paperless/export

# Run backup
restic backup "$EXPORT_PATH"

# Prune old snapshots
restic forget \
    --keep-daily 7 \
    --keep-weekly 4 \
    --keep-monthly 12 \
    --prune
