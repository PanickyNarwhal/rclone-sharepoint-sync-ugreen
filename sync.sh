#!/bin/bash
### Rclone Site Sync Script for SharePoint on UGreenOS
# Configuration
DESTINATION=""
# This path MUST be where your rclone.conf is actually located
#config = "/(your-volume)/.config/rclone/rclone.conf"
#log = "/(your-volume)/rclone/last_sync.log"
CONFIG_PATH=
LOG_FILE=

# Format to "FolderName|RemoteName"
# example: "Documents|sharepoint:site/Team/Documents"
LIBS=(
  "Documents|sharepoint:site/Team/Documents"
)

echo ">>> Starting Individual Remote Sync. . ."

for entry in "${LIBS[@]}"; do
    FOLDER="${entry%%|*}"
    REMOTE_NAME="${entry#*|}"

    echo "----------------------------------------------------"
    echo "Syncing $FOLDER using remote $REMOTE_NAME"
    echo "----------------------------------------------------"

    # Ensure the folder exists on the NAS
    mkdir -p "$DESTINATION/$FOLDER"

    /usr/bin/rclone --config "$CONFIG_PATH" sync "$REMOTE_NAME": "$DESTINATION/$FOLDER" \
      --size-only \
      --tpslimit 3 \
      --log-file "$LOG_FILE" \
  --log-level INFO
done

echo ">>> All Syncs Complete."