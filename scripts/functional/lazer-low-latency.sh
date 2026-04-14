#!/bin/bash
PIPEWIRE_ALSA="alsa.buffer-bytes=1024 alsa.period-bytes=64" \
PIPEWIRE_LATENCY=32/48000 \
OBS_VKCAPTURE=1 \
obs-gamecapture /home/izunamori/.local/bin/lazertweaks %U
