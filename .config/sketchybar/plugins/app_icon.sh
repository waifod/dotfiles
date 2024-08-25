#!/bin/sh

source "${XDG_CONFIG_HOME:-$HOME/.config}"/icons.sh

case "$1" in
"Terminal" | "iTerm2")
  	RESULT=$ICON_TERM
	;;
"Finder")
	RESULT=$ICON_FILE
	;;
"Weather")
	RESULT=$ICON_WEATHER
	;;
"DeepL")
	RESULT=$ICON_TRANSLATE
	;;
"Clock")
	RESULT=$ICON_CLOCK
	;;
"Mail" | "Microsoft Outlook" | "Betterbird" | "Proton Mail"*)
	RESULT=$ICON_MAIL
	;;
SelfControl*)
	RESULT=$ICON_POMODORO
	;;
"Calendar")
	RESULT=$ICON_CALENDAR
	;;
"Calculator" | "Numi" | "Wolfram|Alpha")
	RESULT=$ICON_CALC
	;;
"Slack" | "Microsoft Teams" | "Vesktop" | "Telegram" | "Signal" | "WhatsApp")
	RESULT=$ICON_CHAT
	;;
"FaceTime" | "zoom.us" | "Webex" | "Amazon Chime")
	RESULT=$ICON_VIDEOCHAT
	;;
"Notes" | "TextEdit" | "Obsidian" | "Microsoft Word" | "PDFgear")
	RESULT=$ICON_NOTE
	;;
"Photo Booth")
	RESULT=$ICON_CAMERA
	;;
"Safari" | "Google Chrome" | "Firefox")
	RESULT=$ICON_WEB
	;;
"System Settings" | "System Information" | "TinkerTool")
	RESULT=$ICON_COG
	;;
"Music" | "Spotify" | "Ooooo")
	RESULT=$ICON_MUSIC
	;;
"FreeTube" | "VLC" | "QuickTime Player" | "Netflix")
	RESULT=$ICON_PLAY
	;;
"Books" | "Dictionary")
	RESULT=$ICON_BOOK
	;;
"Code" | "Xcode" | "VSCodium" | "Neovide" | "IntelliJ IDEA" | "CLion")
	RESULT=$ICON_DEV
	;;
"Keka")
	RESULT=$ICON_ZIP
	;;
"Font Book")
	RESULT=$ICON_FONT
	;;
"Activity Monitor")
	RESULT=$ICON_CHART
	;;
"Disk Utility")
	RESULT=$ICON_DISK
	;;
"Preview" | "ImageOptim" | "Shottr")
	RESULT=$ICON_IMAGE
	;;
"Proton Pass" | "Ente Auth")
	RESULT=$ICON_PASSKEY
	;;
*VPN)
	RESULT=$ICON_VPN
	;;
"Progressive Downloader")
	RESULT=$ICON_DOWNLOAD
	;;
"Microsoft Excel")
	RESULT=$ICON_TABLE
	;;
"Microsoft PowerPoint")
	RESULT=$ICON_PRESENT
	;;
"Microsoft Remote Desktop")
	RESULT=$ICON_REMOTEDESKTOP
	;;
"MacDroid" | "uad_gui-macos")
	RESULT=$ICON_ANDROID
	;;
"App Store" | "Latest")
	RESULT=$ICON_APPSTORE
	;;
"AppCleaner")
	RESULT=$ICON_CLEAN
	;;
"DB Browser for SQLite")
	RESULT=$ICON_DATABASE
	;;
*)
	RESULT=$ICON_APP
	;;
esac

echo $RESULT
