#!/bin/bash

# --- SET MIN AND MAX VALUES HERE ---
MIN=5    # Minimum brightness value (%)
MAX=100  # Maximum brightness value (%)
STEP=5   # Step value
# -----------------------------------

# Take current and max value
CURRENT_ABS=$(brightnessctl get)
MAX_ABS=$(brightnessctl m)

# Calculate current percentage
CURRENT_PCT=$(( CURRENT_ABS * 100 / MAX_ABS ))

# Calculate target brightness value (in memory, without touching the screen)
if [ "$1" == "StepUp" ]; then
    TARGET=$(( CURRENT_PCT + STEP ))
elif [ "$1" == "StepDown" ]; then
    TARGET=$(( CURRENT_PCT - STEP ))
else
    exit 1
fi

# Limit target value so it doesn't exceed MIN or MAX
if [ "$TARGET" -lt "$MIN" ]; then
    TARGET=$MIN
elif [ "$TARGET" -gt "$MAX" ]; then
    TARGET=$MAX
fi

# Apply the change to the screen ONLY ONCE (plus -q to avoid terminal noise)
brightnessctl set ${TARGET}% -q

# Send a notification with a progress bar (captured by swaync)
notify-send -e -a "System" -u low \
    -h string:x-canonical-private-synchronous:brightness_osd \
    -h int:value:"$TARGET" \
    "Brightness: ${TARGET}%"
