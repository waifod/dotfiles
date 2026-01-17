#!/bin/bash

MAGNET_LINK="$1"

if [ -z "$MAGNET_LINK" ]; then
  echo "Error: No magnet link provided."
  exit 1
fi

url_decode() {
  # Replace '+' with space (common in URL encoding)
  local url_encoded="${1//+/ }"
  # Use printf logic to interpret %XX as hex characters
  printf '%b' "${url_encoded//%/\\x}"
}

is_daemon_running() {
  pidof transmission-daemon >/dev/null
}

if ! is_daemon_running; then
  notify-send -t 5000 "Transmission" "Daemon offline. Starting..."
  transmission-daemon

  MAX_RETRIES=20
  COUNT=0

  while ! transmission-remote -l &>/dev/null; do
    sleep 0.5
    COUNT=$((COUNT + 1))
    if [ "$COUNT" -ge "$MAX_RETRIES" ]; then
      notify-send -t 5000 --urgency=critical "Transmission error" "Daemon started but RPC is unresponsive."
      exit 1
    fi
  done
fi

RAW_NAME=$(echo "$MAGNET_LINK" | grep -oP 'dn=\K[^&]+')

if [ -n "$RAW_NAME" ]; then
  TORRENT_NAME=$(url_decode "$RAW_NAME")
else
  TORRENT_NAME="Unknown torrent (metadata pending)"
fi

notify-send -t 5000 --icon=network-transmit-receive "Download started" "$TORRENT_NAME"

transmission-remote --add "$MAGNET_LINK"
