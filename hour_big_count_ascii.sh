#!/bin/bash

doble_point=$(cat <<'EOF'
    
 /$$
|__/
    
 /$$
|__/
    
    
EOF
)

H=$(cat <<'EOF'
 /$$   /$$
| $$  | $$
| $$  | $$
| $$$$$$$$
| $$__  $$
| $$  | $$
| $$  | $$
|__/  |__/
EOF
)

O=$(cat <<'EOF'
  /$$$$$$ 
 /$$__  $$
| $$  \ $$
| $$  | $$
| $$  | $$
| $$  | $$
|  $$$$$$/
 \______/ 
EOF
)

R=$(cat <<'EOF'
 /$$$$$$$ 
| $$__  $$
| $$  \ $$
| $$$$$$$/
| $$__  $$
| $$  \ $$
| $$  | $$
|__/  |__/
EOF
)

A=$(cat <<'EOF'
  /$$$$$$ 
 /$$__  $$
| $$  \ $$
| $$$$$$$$
| $$__  $$
| $$  | $$
| $$  | $$
|__/  |__/
EOF
)

S=$(cat <<'EOF'
  /$$$$$$ 
 /$$__  $$
| $$  \__/
|  $$$$$$ 
 \____  $$
 /$$  \ $$
|  $$$$$$/
 \______/ 
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
        H) echo "$H" ;;
        O) echo "$O" ;;
        R) echo "$R" ;;
        A) echo "$A" ;;
        S) echo "$S" ;;
    esac
}

ACOUNTER=$HOME/.acounter
CUR_DATE_HR=$(date +%Y%m%d%H%M)
CUR_EPOCH=$(date +%s)

if [ ! -s "$ACOUNTER" ]; then
    echo -n "$CUR_DATE_HR" > "$ACOUNTER"
fi

LAST_LINE=$(tail -n 1 "$ACOUNTER")
if [ ${#LAST_LINE} -lt 12 ]; then
    echo "" >> "$ACOUNTER"
    echo -n "$CUR_DATE_HR" >> "$ACOUNTER"
    LAST_LINE="$CUR_DATE_HR"
fi

BASE_DATE_HR=${LAST_LINE:0:12}
DOTS=${LAST_LINE:12}
NUM_DOTS=${#DOTS}

YEAR=${BASE_DATE_HR:0:4}
MON=${BASE_DATE_HR:4:2}
DAY=${BASE_DATE_HR:6:2}
HR=${BASE_DATE_HR:8:2}
MIN=${BASE_DATE_HR:10:2}

if ! BASE_EPOCH=$(date -d "$YEAR-$MON-$DAY $HR:$MIN:00" +%s 2>/dev/null); then
    BASE_EPOCH=$CUR_EPOCH
    echo "" >> "$ACOUNTER"
    echo -n "$CUR_DATE_HR" >> "$ACOUNTER"
fi

EXPECTED_EPOCH=$(( BASE_EPOCH + NUM_DOTS * 3600 ))
DIFF_HOURS=$(( (CUR_EPOCH - EXPECTED_EPOCH) / 3600 ))

if [ "$DIFF_HOURS" -eq 1 ]; then
    echo -n "." >> "$ACOUNTER"
elif [ "$DIFF_HOURS" -gt 1 ] || [ $(( CUR_EPOCH )) -lt $(( EXPECTED_EPOCH )) ]; then
    echo "" >> "$ACOUNTER"
    echo -n "$CUR_DATE_HR" >> "$ACOUNTER"
fi

TOTAL_DOTS=$(grep -o "\." "$ACOUNTER" | wc -l)

if [ "$TOTAL_DOTS" -eq 1 ]; then
    disp_string="${TOTAL_DOTS}HORA"
else
    disp_string="${TOTAL_DOTS}HORAS"
fi

output=''

chars=($(echo "$disp_string" | sed 's/./& /g'))

for char in "${chars[@]}"; do
    block=$(digit_to_ascii "$char")
    
    mapfile -t block_lines <<< "$block"

    if [ -z "$output" ]; then
        output=("${block_lines[@]}")
    else
        for i in "${!block_lines[@]}"; do
            if [ -z "${output[i]}" ]; then
                output[i]="${block_lines[i]}"
            else
                output[i]="${output[i]} ${block_lines[i]}"
            fi
        done
    fi
done

TMP_FILE='/tmp/idle_tracker.tmp'
LIMIT=5  # 5 segundos

eval $(xdotool getmouselocation --shell)
CUR_X=$X
CUR_Y=$Y
CUR_TIME=$(date +%s)

if [ ! -f "$TMP_FILE" ]; then
    echo "$CUR_X $CUR_Y $CUR_TIME" > "$TMP_FILE"
    exit 1
fi

read LAST_X LAST_Y LAST_TIME < "$TMP_FILE"

if [ "$CUR_X" != "$LAST_X" ] || [ "$CUR_Y" != "$LAST_Y" ]; then
    LAST_TIME=$CUR_TIME
fi

echo "$CUR_X $CUR_Y $LAST_TIME" > "$TMP_FILE"

IDLE=$(( CUR_TIME - LAST_TIME ))

if [ "$IDLE" -ge "$LIMIT" ]; then
    touch $HOME/.big_hour_counter
    XEPHYR_ACTIVE=$(xdotool search --name "ctrl+shift releases" 2>/dev/null)
    printf '%s\n' "${output[@]}" | osd_cat --pos=bottom --align=left --shadow=1 --delay=1 --lines=8 \
        --color="$([ -n "$XEPHYR_ACTIVE" ] && echo 'red' || ( grep -q 'NOT MOUSE' $HOME/.xbindkeysrc && echo 'green' || echo 'orange' ))"
    exit 0
else
    [ -f $HOME/.big_hour_counter ] && rm $HOME/.big_hour_counter
    exit 1
fi