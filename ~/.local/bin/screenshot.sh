#!/bin/bash

# Ensure directory exists
mkdir -p "$HOME/Pictures/Screenshots"

# Generate filename
FILENAME="$HOME/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S').png"

if [ "$1" == "full" ]; then
    grim "$FILENAME"
elif [ "$1" == "custom" ]; then
    grim -g "$(slurp)" "$FILENAME"
fi
