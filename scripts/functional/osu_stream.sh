#!/bin/sh

pgrep -x tosu || tosu &
obs &
env OBS_VKCAPTURE=1 obs-gamecapture osu-wine &