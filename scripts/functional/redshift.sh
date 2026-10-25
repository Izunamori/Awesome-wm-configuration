#!/bin/bash

STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/redshift-manual-state"

set_brightness() {
    local display="$1"
    local brightness="$2"

    for _ in {1..3}; do
        if ddcutil setvcp 10 "$brightness" --display "$display"; then
            return 0
        fi
        sleep 0.5
    done

    return 1
}

if [[ -f "$STATE_FILE" ]]; then
    redshift -x

    sleep 0.3
    set_brightness 2 20

    rm -f "$STATE_FILE"
else
    redshift -O 3500

    sleep 0.3
    set_brightness 2 0

    touch "$STATE_FILE"
fi