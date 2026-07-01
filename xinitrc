#!/bin/sh

# Obtener secretos de ~/.obfuscate
get_secret() {
    [ -f "$HOME/.obfuscate" ] && sed -n "${1}p" "$HOME/.obfuscate"
}

setxkbmap latam
xset r rate 150 110
feh --bg-scale $HOME/monoliths-hm/white-background.png &

# 3. Calibración y apps de inicio
(sleep 0.5 && xcalib -i -a && touch /tmp/_xcalib_working) &

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax --exit-with-session)
fi

# touchpad :
# Nombre exacto del dispositivo según xinput list
DEVICE="ELAN0791:00 04F3:30FD Touchpad"
# Obtenemos el estado actual del dispositivo (1 = encendido, 0 = apagado)
# Usamos awk para extraer el último valor de la línea "Device Enabled"
STATE=$(xinput list-props "$DEVICE" | grep "Device Enabled" | awk '{print $NF}')
# Evaluamos el estado y lo cambiamos
if [ "$STATE" = "1" ]; then
    xinput disable "$DEVICE"
    echo "Touchpad desactivado."
elif [ "$STATE" = "0" ]; then
    xinput enable "$DEVICE"
    echo "Touchpad activado."
else
    echo "Error: No se pudo determinar el estado actual del touchpad."
fi
CURRENT_TTY=$(tty)
# 4. Lanzar aplicaciones de trabajo (con & para que no bloqueen el inicio)
NOGUI=false
if [ "$CURRENT_TTY" = "/dev/tty1" ]; then
    # MIXEDCOLOR=''
    while true; do sleep 1; emacs $MIXEDCOLOR -mm --debug-init; done &
    while true; do dash ~/monoliths-llm/a-llm-yad.sh; sleep 0.1; done &
    sleep 2
    while true; do
        if ! wmctrl -lx | awk '{print $3}' | grep -qi 'google-chrome'; then
            google-chrome-stable https://web.whatsapp.com https://mail.google.com/mail/u/1 &
        fi
        sleep 0.5
    done &
    while ! pgrep scrcpy > /dev/null; do
	# 1. Validar si el celular está conectado físicamente al puerto USB
	if ! grep -qi 'android' /sys/bus/usb/devices/*/product 2>/dev/null; then
            echo '[USB] Esperando a que conectes el celular por USB...'
            sleep 0.5
            continue
	fi

	# 2. Si está conectado por USB, validar si ADB ya lo reconoce
	if adb devices | grep -v 'List of devices' | grep -q 'device'; then
            echo '[ADB] ¡Celular detectado y listo! Iniciando scrcpy...'
            scrcpy -d || adb kill-server && adb start-server
	else
            echo '[ADB] Celular detectado por USB, pero no por ADB. Reiniciando servidor...'
            adb kill-server && adb start-server && scrcpy -d || killall scrcpy
	fi
	sleep 0.5
    done &
    while true; do '/opt/Antigravity IDE/antigravity-ide' ~/app-asociados-android; sleep 0.1; done &
elif [ "$CURRENT_TTY" = "/dev/tty2" ]; then
    sleep 1 && gromit-mpx &
    sleep 3 && chromium-native --app=https://gmail.com &
    sleep 3 && chromium-native --app="$(get_secret 5)" &
    sleep 3 && chromium-native --app=http://localhost:5173 &
elif [ "$CURRENT_TTY" = "/dev/tty3" ]; then
    sleep 1 && dash ~/literatura/message_img.sh 'Literatura desde cualquier idioma al español' &
    sleep 1 && cd ~/literatura; while true; do dash literatura.sh; done &
    if [ ! -f /tmp/clock_is_run_already.pid ]; then
        while true; do
            if [ ! -f $HOME/.stop_personal_osdx ]; then
                touch /tmp/clock_is_run_already.pid
                dash $HOME/monoliths-hm/optime.personal_osdx.sh
            fi
            sleep 0.1
        done &
    fi
elif [ "$CURRENT_TTY" = "/dev/tty4" ]; then
    sleep 1 && dash ~/literatura/message_img.sh 'Literatura desde cualquier idioma al alemán' &
    sleep 1 && cd ~/Literatur; while true; do dash literatura.sh; done &
else
    while true; do sleep 1; emacs $MIXEDCOLOR -mm --debug-init; done &
    while true; do dash ~/monoliths-llm/a-llm-yad.sh; sleep 0.1; done &
fi
pgrep xbindkeys | xargs kill
sleep 0.1
sleep 1.5 && xbindkeys &

# exec start-lumina-desktop
if doas dmesg | grep -q ZenBook > /dev/null; then
    dash $HOME/monoliths-llm/enfriar-asus.sh &

    deskflow-server -c $HOME/deskflow.conf &
else
    # --- Configuración de variables ---
    if false; then
	TIEMPO_ESPERA=12

	dash $HOME/monoliths-llm/enfriar-hp.sh &

	# 1. Iniciar input-leap en segundo plano (como demonio con config)
	input-leap &

	# 2. Cuenta regresiva y xdotool en segundo plano para no bloquear Openbox
	(
            (
		i=$TIEMPO_ESPERA
		while [ "$i" -gt 0 ]; do
                    echo "Lanzando macro input-leap en: $i"
                    sleep 1
                    i=$((i - 1))
		done
            ) | osd_cat -p middle -A center -l 1 -c green -d 1

            # 3. Secuencia de pulsaciones y escritura
            xdotool key Alt+c
            sleep 0.5
            xdotool key Alt+c
            sleep 0.5
            xdotool key Alt+c
            sleep 0.5
            xdotool key Alt+c
	    sleep 0.5
            xdotool key Tab
	    sleep 0.5
	    xdotool type '192.168.0.162'
            sleep 0.5
            xdotool key Tab
            sleep 0.5
            xdotool key space
            sleep 0.5
            xdotool key Tab
            sleep 0.5
            xdotool key space
	    sleep 0.5 && wmctrl -i -r "$(wmctrl -l | awk '/InputLeap/ {print $1}')" -b add,hidden

	) &
    fi
fi

while true; do  sleep 1; st; done &

if ! $NOGUI; then
    exec openbox-session
fi