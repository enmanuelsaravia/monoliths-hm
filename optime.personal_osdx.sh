#!/bin/dash

# 1. Obtener porcentaje y estado usando /sys/class/power_supply para mayor robustez
PERC=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo 0)
ONLINE=$(cat /sys/class/power_supply/ADP1/online 2>/dev/null || echo 0)

# 2. Lógica de iconos con bloques
if [ "$ONLINE" -eq 1 ]; then
    BAT='⚡'
else
    # Lógica de bloques según porcentaje
    if [ "$PERC" -ge 85 ]; then
        BAT='[███]'
    elif [ "$PERC" -ge 40 ]; then
        BAT='[██░]'
    elif [ "$PERC" -ge 15 ]; then
        BAT='[█░░]'
    else
        BAT='[░░░]'
    fi
fi

# 3. Formatear la salida (12h con p.m./a.m. en español)
OPT="$PERC%"
TIME=$(LC_ALL=es_PE.utf8 TZ=America/Lima date +' %I:%M %p' | tr '[:upper:]' '[:lower:]' | sed 's/am/a.m./;s/pm/p.m./')

# 4. Lógica de visualización con xdotool en vez de wmctrl
# Si no hay batería o capacidad es 0, ocultar info de batería si se desea, 
# pero aquí mantengo el comportamiento original simplificado.

XEPHYR_ACTIVE=$(xdotool search --name "ctrl+shift releases" 2>/dev/null)
KEYBOARD_MODE=$(grep -q 'NOT MOUSE' "$HOME/.xbindkeysrc" 2>/dev/null && echo 'Keyboard quit Alt+2' || echo 'Mouse quit Alt+1')

printf "\n\n%s\n%s" \
       "$([ ! -f $HOME/.big_hour ] && echo -n $BAT $OPT $TIME)" \
       "$([ -n "$XEPHYR_ACTIVE" ] && echo 'Xephyr quit Ctrl+Shift' || echo "$KEYBOARD_MODE")" | \
    osd_cat --pos=top --align=right --offset=50 \
        --color="$([ -n "$XEPHYR_ACTIVE" ] && echo 'red' || (grep -q 'NOT MOUSE' "$HOME/.xbindkeysrc" 2>/dev/null && echo 'green' || echo 'orange'))" \
        --shadow=1 --delay=1 --lines=4

bash $HOME/monoliths-hm/hour_big_ascii.sh