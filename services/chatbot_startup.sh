#!/usr/bin/env bash


COMPOSE_DIR="/mnt/linux_data/Local Chatbot/open-webui/"
LOG_DIR="/var/log/chatbot-docker"
LOG_FILE="${LOG_DIR}/docker_compose_$(date +'%Y-%m-%d').log"

# Function to wait until the mount becomes available
wait_for_mount() {
    echo "Waiting for ${COMPOSE_DIR} to become available..." >> "$LOG_FILE"
    while [ ! -d "$COMPOSE_DIR" ]; do
        sleep 2
    done

    # Additional check: ensure filesystem is actually mounted
    while ! mountpoint -q "$COMPOSE_DIR"; do
        sleep 2
    done

    echo "$(date): Mount available." >> "$LOG_FILE"
}

wait_for_mount

# Change to directory
cd "$COMPOSE_DIR" || {
    echo "$(date): ERROR — cannot cd into ${COMPOSE_DIR}" >> "$LOG_FILE"
    exit 1
}

# Run Docker Compose
echo "$(date): Starting docker compose..." >> "$LOG_FILE"
docker compose up -d >> "$LOG_FILE" 2>&1
echo "$(date): Docker compose started." >> "$LOG_FILE"
