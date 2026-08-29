#!/bin/bash

STATE_FILE="${XDG_RUNTIME_DIR:-/tmp}/redshift-manual-state"

if [[ -f "$STATE_FILE" ]]; then
    redshift -x
    rm -f "$STATE_FILE"
else
    redshift -O 3500
    touch "$STATE_FILE"
fi