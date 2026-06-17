#!/bin/dash

if [ -z "$1" ]; then
    for dir in /home/*; do
	if [ -d "$dir/.config" ] && ls "$dir/.config/lumina"* &>/dev/null; then
	    echo "Borrando $dir/.config/lumina*"
	    rm -rf "$dir/.config/lumina"*
	else
	    echo "No existe lumina* en $dir/.config"
	fi
    done
fi

if [ ! -z "$1" ]; then
    dir="/home/$1"
    if [ -d "$dir/.config" ] && ls "$dir/.config/lumina"* &>/dev/null; then
	echo "Borrando $dir/.config/lumina*"
	rm -rf "$dir/.config/lumina"*
    else
	echo "No existe lumina* en $dir/.config"
    fi
fi