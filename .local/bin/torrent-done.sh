#!/bin/bash

notify-send --app-name="Transmission" \
  --icon="network-transmit-receive" \
  "Download completed" \
  "${TR_TORRENT_NAME} has finished."
