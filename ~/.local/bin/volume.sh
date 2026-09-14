#!/bin/bash

STEP=5

# Execute changes based on argument
if [ "$1" == "StepUp" ]; then
    # -l 1.0 limits maximum volume to 100%
    wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ ${STEP}%+
elif [ "$1" == "StepDown" ]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ ${STEP}%-
elif [ "$1" == "ToggleMute" ]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
else
    exit 1
fi

# Get current volume status
VOL_STRING=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
# Extract the number and convert to percentage
VOL=$(echo "$VOL_STRING" | awk '{print int($2 * 100)}')

# Check if currently muted
if echo "$VOL_STRING" | grep -q "MUTED"; then
    notify-send -e -a "System" -u low -h string:x-canonical-private-synchronous:volume_osd "Volume: Muted"
else
    notify-send -e -a "System" -u low -h string:x-canonical-private-synchronous:volume_osd -h int:value:"$VOL" "Volume: ${VOL}%"
fi
