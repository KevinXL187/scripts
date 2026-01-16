#!/usr/bin/env bash

COMPOSE_DIR="/mnt/linux_data/Local Chatbot/open-webui/"
LOG_DIR="/var/log/chatbot-docker"
LOG_FILE="${LOG_DIR}/docker_compose_down_$(date +'%Y-%m-%d').log"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Change to directory
cd "$COMPOSE_DIR" || {
    echo "$(date): ERROR — cannot cd into ${COMPOSE_DIR}" >> "$LOG_FILE"
    exit 1
}

# Run Docker Compose Down
echo "$(date): Stopping docker compose..." >> "$LOG_FILE"
docker compose down >> "$LOG_FILE" 2>&1

if [[ $? -eq 0 ]]; then
    echo "$(date): Docker compose stopped successfully." >> "$LOG_FILE"
else
    echo "$(date): ERROR — docker compose down failed." >> "$LOG_FILE"
fi
