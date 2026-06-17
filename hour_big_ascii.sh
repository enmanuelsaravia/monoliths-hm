#!/bin/bash

doble_point=$(cat <<'EOF'
    
 /$$
|__/
    
 /$$
|__/
    
    
EOF
)

v0=$(cat <<'EOF'
  /$$$$$$ 
 /$$$_  $$
| $$$$\ $$
| $$ $$ $$
| $$\ $$$$
| $$ \ $$$
|  $$$$$$/
 \______/ 
EOF
)
v1=$(cat <<'EOF'
   /$$  
 /$$$$  
|_  $$  
  | $$  
  | $$  
  | $$  
 /$$$$$$
|______/
EOF
)
v2=$(cat <<'EOF'
  /$$$$$$ 
 /$$__  $$
|__/  \ $$
  /$$$$$$/
 /$$____/ 
| $$      
| $$$$$$$$
|________/
EOF
)
v3=$(cat <<'EOF'
  /$$$$$$ 
 /$$__  $$
|__/  \ $$
   /$$$$$/
  |___  $$
 /$$  \ $$
|  $$$$$$/
 \______/ 
EOF
)
v4=$(cat <<'EOF'
 /$$   /$$
| $$  | $$
| $$  | $$
| $$$$$$$$
|_____  $$
      | $$
      | $$
      |__/
EOF
)
v5=$(cat <<'EOF'
 /$$$$$$$ 
| $$____/ 
| $$      
| $$$$$$$ 
|_____  $$
 /$$  \ $$
|  $$$$$$/
 \______/ 
EOF
)
v6=$(cat <<'EOF'
  /$$$$$$ 
 /$$__  $$
| $$  \__/
| $$$$$$$ 
| $$__  $$
| $$  \ $$
|  $$$$$$/
 \______/ 
EOF
)
v7=$(cat <<'EOF'
 /$$$$$$$$
|_____ $$/
     /$$/ 
    /$$/  
   /$$/   
  /$$/    
 /$$/     
|__/      
EOF
)
v8=$(cat <<'EOF'
  /$$$$$$ 
 /$$__  $$
| $$  \ $$
|  $$$$$$/
 >$$__  $$
| $$  \ $$
|  $$$$$$/
 \______/ 
EOF
)
v9=$(cat <<'EOF'
  /$$$$$$ 
 /$$__  $$
| $$  \ $$
|  $$$$$$$
 \____  $$
 /$$  \ $$
|  $$$$$$/
 \______/ 
EOF
)

# #ejemplo
# echo "$doble_point" | awk '{print $0 " " $0}' | osd_cat -p top -A center -d 5

# Tus bloques ASCII: v0…v9 y doble_point

digit_to_ascii() {
    case "$1" in
        0) echo "$v0" ;;
        1) echo "$v1" ;;
        2) echo "$v2" ;;
        3) echo "$v3" ;;
        4) echo "$v4" ;;
        5) echo "$v5" ;;
        6) echo "$v6" ;;
        7) echo "$v7" ;;
        8) echo "$v8" ;;
        9) echo "$v9" ;;
        :) echo "$doble_point" ;;
    esac
}

# current_time=$(date +'%T')  # HH:MM:SS
current_time=$(TZ=America/Lima date +'%I:%M:%S')  # 12h:MM:SS (1-indexed for some digits)
output=''  # inicializamos como array de líneas vacías

# Convertimos la hora en array de caracteres
chars=($(echo "$current_time" | sed 's/./& /g'))

for char in $(echo "$current_time" | sed 's/./& /g'); do
    block=$(digit_to_ascii "$char")
    
    # Convertimos el bloque en un array de líneas
    mapfile -t block_lines <<< "$block"

    # Si output está vacío, lo inicializamos
    if [ -z "$output" ]; then
        output=("${block_lines[@]}")
    else
        # Concatenar línea por línea
        for i in "${!block_lines[@]}"; do
            # Si no existe la línea correspondiente en output, agregarla
            if [ -z "${output[i]}" ]; then
                output[i]="${block_lines[i]}"
            else
                output[i]="${output[i]} ${block_lines[i]}"
            fi
        done
    fi
done

# # Imprimimos todo respetando saltos de línea y espacios en bash
# for line in "${output[@]}"; do
#     printf '%s\n' "$line"
# done

TMP_FILE='/tmp/idle_tracker.tmp'
LIMIT=100  # 5 minutos en segundos

# Obtener posición actual del mouse
eval $(xdotool getmouselocation --shell)
CUR_X=$X
CUR_Y=$Y
CUR_TIME=$(date +%s)

# Si el archivo tmp no existe, inicializarlo
if [ ! -f "$TMP_FILE" ]; then
    echo "$CUR_X $CUR_Y $CUR_TIME" > "$TMP_FILE"
    exit 1  # No hay suficiente info aún
fi

# Leer información anterior
read LAST_X LAST_Y LAST_TIME < "$TMP_FILE"

# Comparar posición
if [ "$CUR_X" != "$LAST_X" ] || [ "$CUR_Y" != "$LAST_Y" ]; then
    # Mouse se movió, reiniciar tiempo
    LAST_TIME=$CUR_TIME
fi

# Guardar estado actualizado
echo "$CUR_X $CUR_Y $LAST_TIME" > "$TMP_FILE"

# Calcular tiempo de inactividad
IDLE=$(( CUR_TIME - LAST_TIME ))

if [ "$IDLE" -ge "$LIMIT" ]; then
    touch $HOME/.big_hour
    # Mostrar con osd_cat
    XEPHYR_ACTIVE=$(xdotool search --name "ctrl+shift releases" 2>/dev/null)
    printf '%s\n' "${output[@]}" | osd_cat --pos=bottom --align=right --shadow=1 --delay=1 --lines=8 \
        --color="$([ -n "$XEPHYR_ACTIVE" ] && echo 'red' || ( grep -q 'NOT MOUSE' $HOME/.xbindkeysrc && echo 'green' || echo 'orange' ))"
    exit 0
else
    [ -f $HOME/.big_hour ] && rm $HOME/.big_hour
    exit 1
fi