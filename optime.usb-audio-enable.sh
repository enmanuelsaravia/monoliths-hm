#!/bin/dash
if command -v touch | grep -q touch && \
	command -v doas | grep -q doas && \
	command -v tee | grep -q tee && \
	command -v mv | grep -q mv; then
    [ -f /etc/modprobe.d/alsa.conf ] && doas mv /etc/modprobe.d/alsa.conf /etc/modprobe.d/alsa.conf.optime.usb-audio-enable.backup~
    doas touch /etc/modprobe.d/alsa.conf
    echo 'options snd_usb_audio index=0' | doas tee '/etc/modprobe.d/alsa.conf'
else
    echo 'doas, touch, mv and tee is required'
fi
