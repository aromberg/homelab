#!/bin/bash
set -euo pipefail

RESTIC_REPOSITORY_FILE="/mnt/data/ocis/backup/restic-repo"
RESTIC_PASSWORD_FILE="/mnt/data/ocis/backup/restic-password"
AWS_ENV_FILE="/mnt/data/ocis/backup/restic-aws.env"
BACKUP_PATH="/mnt/data/ocis"
COMPOSE_DIR="/opt/homelab/ocis"

# Load AWS credentials
set -a
source "$AWS_ENV_FILE"
set +a

export RESTIC_REPOSITORY="$(cat "$RESTIC_REPOSITORY_FILE")"
export RESTIC_PASSWORD="$(cat "$RESTIC_PASSWORD_FILE")"

echo "Stopping OCIS..."
docker compose -f "$COMPOSE_DIR/docker-compose.yml" stop

echo "Running backup..."
restic backup "$BACKUP_PATH" \
    --exclude "$BACKUP_PATH/backup"

echo "Pruning old snapshots..."
restic forget \
    --keep-daily 7 \
    --keep-weekly 4 \
    --keep-monthly 12 \
    --prune

echo "Starting OCIS..."
docker compose -f "$COMPOSE_DIR/docker-compose.yml" start

echo "Done."
