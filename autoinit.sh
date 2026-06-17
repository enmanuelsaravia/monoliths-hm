#!/bin/dash
xset r rate 140 60
# Detectar ID del touchpad
# TPID=$(xinput list | grep -i touchpad | awk -F'id=' '{print $2}' | awk '{print $1}')
# xinput disable $TPID
xset s off && xset s noblank && xset -dpms
xbattmon &
sleep 3s
xdotool key Return
sleep 3s
xdotool key Return
