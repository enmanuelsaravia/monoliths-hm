#!/bin/sh
for player in $(dbus-send --print-reply --dest=org.freedesktop.DBus /org/freedesktop/DBus org.freedesktop.DBus.ListNames | awk '/org.mpris.MediaPlayer2./ {split($0, a, "\""); print a[2]}'); do
    dbus-send --print-reply --dest=$player /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause
done
