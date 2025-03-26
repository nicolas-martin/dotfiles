#!/bin/zsh

CPU_TEMP="$($HOME/.local/bin/smctemp -c)"
# CPU_TMP="$(smctemp -c)"
# cpu

sketchybar --set cputemp label="$CPU_TEMP ºC"
