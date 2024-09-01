#!/usr/bin/bash
if [[ "$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/battery-level/ {print $NF}')" != "unknown" ]]; then
    echo "$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/percentage/ {print $NF}')"
fi

