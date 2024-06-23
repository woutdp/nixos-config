#!/bin/sh

while true; do
	player_status=$(playerctl -p spotify status 2>/dev/null)
	artist=$(playerctl -p spotify metadata artist)
	title=$(playerctl -p spotify metadata title)
	artist=$(echo "$artist" | sed 's/&/&amp;/g')

	title=$(echo "$title" | sed 's/&/&amp;/g')

	if [ "$player_status" = "Playing" ]; then
		echo '{"text": "'"$artist - $title"'", "class": "custom-spotify"}'
	elif [ "$player_status" = "Paused" ]; then
		echo '{"text": "'" $artist - $title"'", "class": "custom-spotify"}'
	fi
	sleep 1
done
