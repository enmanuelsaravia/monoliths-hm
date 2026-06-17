#!/bin/bash

# ==============================================================================
# KVM Keyboard Watchdog - Versión Servicio
# ==============================================================================

# --- Configuración ---
KVM_PROCESSES="deskflow|input-leap|barrier|synergy"
NORMAL_RATE="150 110"
BOUNCE_THRESHOLD=100 
HOLD_THRESHOLD=0.5   
BEEP_SOUND="/usr/share/sounds/freedesktop/stereo/bell.oga"
LOG_FILE="/tmp/metralleta.log"

exec > >(tee -a "$LOG_FILE") 2>&1

echo "[$(date)] --- INICIANDO SERVICIO METRALLETA ---"

play_beep() {
    if [ -f "$BEEP_SOUND" ]; then paplay "$BEEP_SOUND" &
    else echo -e "\a" > /dev/tty; fi
}

WATCHER_PID=""

start_xinput_watcher() {
    # Intentar encontrar el ID del teclado AT o el master
    KBD_ID=$(xinput list --short | grep -i "keyboard" | grep -v "XTEST" | head -n 1 | sed -n 's/.*id=\([0-9]*\).*/\1/p')
    [ -z "$KBD_ID" ] && KBD_ID=3
    
    echo "[$(date)] Detectado Teclado ID: $KBD_ID. Iniciando monitoreo..."

    (
        declare -A last_press_ms
        declare -A hold_pids

        # Usamos stdbuf para evitar lags en el pipe
        stdbuf -oL xinput test "$KBD_ID" 2>/dev/null | while read -r line; do
            if [[ "$line" == *"key press"* ]]; then
                key=$(echo "$line" | awk '{print $3}')
                now=$(date +%s%3N)
                
                # Rebote
                prev_ms=${last_press_ms[$key]}
                if [ -n "$prev_ms" ]; then
                    delta=$(( now - prev_ms ))
                    if [ $delta -lt $BOUNCE_THRESHOLD ]; then play_beep; fi
                fi
                last_press_ms[$key]=$now

                # Hold
                [ -n "${hold_pids[$key]}" ] && kill "${hold_pids[$key]}" 2>/dev/null
                ( sleep "$HOLD_THRESHOLD"; play_beep ) &
                hold_pids[$key]=$!

            elif [[ "$line" == *"key release"* ]]; then
                key=$(echo "$line" | awk '{print $3}')
                [ -n "${hold_pids[$key]}" ] && { kill "${hold_pids[$key]}" 2>/dev/null; unset "hold_pids[$key]"; }
            fi
        done
    ) &
    WATCHER_PID=$!
}

stop_xinput_watcher() {
    if [ -n "$WATCHER_PID" ]; then
        echo "[$(date)] Deteniendo monitoreo de teclas."
        pkill -P "$WATCHER_PID" 2>/dev/null
        kill "$WATCHER_PID" 2>/dev/null
        WATCHER_PID=""
    fi
}

# --- Bucle ---
LAST_STATE="unknown"

while true; do
    # Buscamos si el KVM está activo
    if pgrep -fi "$KVM_PROCESSES" > /dev/null; then
        CURRENT_STATE="kvm"
    else
        CURRENT_STATE="normal"
    fi

    if [ "$CURRENT_STATE" != "$LAST_STATE" ]; then
        if [ "$CURRENT_STATE" == "kvm" ]; then
            echo "[$(date)] >>> KVM ACTIVADO: Protegiendo sistema..."
            xset r off 2>/dev/null
            start_xinput_watcher
        else
            echo "[$(date)] <<< KVM APAGADO: Restaurando teclado..."
            xset r rate $NORMAL_RATE 2>/dev/null
            stop_xinput_watcher
        fi
        LAST_STATE="$CURRENT_STATE"
    fi
    
    # Bajo consumo: Cuando todo está normal, solo despertamos cada 5 segs
    if [ "$CURRENT_STATE" == "normal" ]; then
        sleep 5
    else
        sleep 2
    fi
done
