#!/bin/dash

# Configuración de idioma (opcional, pero compatible)
export LANG=es_ES.UTF-8
export LC_ALL=es_ES.UTF-8
export LC_CTYPE=UTF-8

# Obtener secretos de ~/.obfuscate
get_secret() {
    [ -f "$HOME/.obfuscate" ] && sed -n "${1}p" "$HOME/.obfuscate"
}


size1='1920 1080'
size2='1024 576'
size3='640 360'
size="$size2"
echo -n "$size" > $HOME/.actual_screen_size
# Configuración de modo de pantalla
MODELINE_NAME=$(cvt $(echo -n $size)  60 | awk '/Modeline/ {print $2}')
MODELINE_PARAMS=$(cvt $(echo -n $size) 60 | awk '/Modeline/ {for(i=3;i<=NF;i++) printf $i " "; print ""}')

xrandr --newmode "$MODELINE_NAME" $MODELINE_PARAMS
xrandr --addmode eDP-1 "$MODELINE_NAME"
xrandr --output eDP-1 --mode "$MODELINE_NAME"

xbindkeys &

# Reloj en segundo plano
if [ ! -f /tmp/clock_is_run_already.pid ]; then
    while true; do
        if [ ! -f $HOME/.stop_personal_osdx ]; then
            touch /tmp/clock_is_run_already.pid
            dash $HOME/monoliths-hm/optime.personal_osdx.sh
        fi
        sleep 0.1
    done &
fi

# Detectar monitores externos
if xrandr | grep -q ' DP-1 connected' || \
        xrandr | grep -q 'DP-2 connected' || \
        xrandr | grep -q 'HDMI-1 connected'; then
    sleep 5
fi

# Configuración específica para ThinkPad
if doas dmesg | grep -q thinkpad 2>/dev/null; then
    if [ "$?" = '0' ]; then
        sleep 2 && cd && dash literatura.sh && dash $HOME/monoliths-hm/autoinit.sh &
        if command -v doas >/dev/null 2>&1; then
            doas service dbus start
            doas service bluetooth start
        else
            sudo service dbus start
            sudo service bluetooth start
        fi
        ( sleep 3 && echo "power on\nexit" | bluetoothctl ) &
    fi
fi

echo 'latam' > /tmp/layout.my
echo 'caps:none' > /tmp/caps_mode.my
echo '' > /tmp/caps_mode.my

# Loop para configuración de teclado
while true; do
    if [ -f /tmp/caps_mode.my ] && [ -f /tmp/layout.my ]; then
        CAPS_MODE=$(cat /tmp/caps_mode.my 2>/dev/null)
        LAYOUT=$(cat /tmp/layout.my 2>/dev/null)
        if [ -n $LAYOUT ]; then
            setxkbmap $LAYOUT
        fi
        if [ -n $CAPS_MODE ]; then
            setxkbmap -option $CAPS_MODE
        fi
    fi
    sleep 1
done &

# Definir cuál ejecutable usar
if [ -f $HOME/PyYad/dist/PyYad ]; then
    YAD=$HOME/PyYad/dist/PyYad
elif command -v yad >/dev/null 2>&1; then
    YAD=yad
else
    echo 'Error: yad no encontrado' >&2
    exit 1
fi

if doas dmesg | grep -q thinkpad 2>/dev/null; then
    sleep 5
    hora=$(date +%H)
    if [ "$hora" -ge 5 ] && [ "$hora" -le 7 ]; then
        echo 'La hora está entre 05:00 y 07:59'
        dash $HOME/monoliths-hm/bloat.raise-volume.sh && (pgrep osd_cat > /dev/null && killall osd_cat || true) && echo -n "[$(echo -n $(amixer | grep '%\]' -m 1) | cut -d[ -f2)" | osd_cat --pos=top --align=right --offset=50 --color=red --shadow=1 --delay=1 --lines=1 && rm $HOME/.amixer_scont*
        sleep 1
        dash $HOME/monoliths-hm/bloat.raise-volume.sh && (pgrep osd_cat > /dev/null && killall osd_cat || true) && echo -n "[$(echo -n $(amixer | grep '%\]' -m 1) | cut -d[ -f2)" | osd_cat --pos=top --align=right --offset=50 --color=red --shadow=1 --delay=1 --lines=1 && rm $HOME/.amixer_scont*
        sleep 1
        dash $HOME/monoliths-hm/bloat.raise-volume.sh && (pgrep osd_cat > /dev/null && killall osd_cat || true) && echo -n "[$(echo -n $(amixer | grep '%\]' -m 1) | cut -d[ -f2)" | osd_cat --pos=top --align=right --offset=50 --color=red --shadow=1 --delay=1 --lines=1 && rm $HOME/.amixer_scont*
        sleep 1
        dash $HOME/monoliths-hm/bloat.raise-volume.sh && (pgrep osd_cat > /dev/null && killall osd_cat || true) && echo -n "[$(echo -n $(amixer | grep '%\]' -m 1) | cut -d[ -f2)" | osd_cat --pos=top --align=right --offset=50 --color=red --shadow=1 --delay=1 --lines=1 && rm $HOME/.amixer_scont*
        sleep 1
        dash $HOME/monoliths-hm/bloat.raise-volume.sh && (pgrep osd_cat > /dev/null && killall osd_cat || true) && echo -n "[$(echo -n $(amixer | grep '%\]' -m 1) | cut -d[ -f2)" | osd_cat --pos=top --align=right --offset=50 --color=red --shadow=1 --delay=1 --lines=1 && rm $HOME/.amixer_scont*
        sleep 1
        mpv --volume=120 $HOME/Downloads/Queen*.webm && mpv --volume=120 $HOME/Downloads/charly.webm &
    fi
else
    # is not thinkpad
    sleep 0.5 && xcalib -i -a &
    touch /tmp/_xcalib_working
    sleep 0.9 && picom --backend glx --no-fading-openclose --inactive-opacity=1.0 --active-opacity=1.0 --frame-opacity=1.0 --no-use-damage --window-shader-fg $HOME/monoliths-llm/blackandwhite.frag &
fi

# xbattmon &

xterm -fa Monospace -bg white -fg black -xrm 'XTerm*color0: white' -xrm 'XTerm*color7: black' -e 'dash $HOME/monoliths-llm/enfriar-asus.sh' &

# Loop principal de menú
while true; do
    # Usar un archivo temporal para el menú para evitar problemas de shell
    OPCION=$(
        "$YAD" --title='Lista de opciones, clic y usar flechas' \
               --width=420 --height=650 \
               --window-icon=$HOME/monoliths-hm/icon.png \
               --list --column='Icono:IMG' --column='Comando' --column='Descripcion' \
               $HOME/monoliths-hm/view-on.png tarea_aurelia 'Taching a.See Tarea' \
               $HOME/monoliths-hm/view-on.png ppf_fe 'Levantar proyectos Pandero portal frontend y frontend' \
               $HOME/monoliths-hm/media-playlist-add.png literatura 'Estudiar sin esfuerzo sin traduccion' \
               $HOME/monoliths-hm/media-playlist-add.png literatura_to_es 'Estudiar sin esfuerzo traducido al spanish' \
               $HOME/monoliths-hm/media-playlist-add.png read_line_by_line 'To pronounce a language words' \
               $HOME/monoliths-hm/appointment-soon.png watch_last 'Ver el ultimo video' \
               $HOME/monoliths-hm/appointment-soon.png quitar_ruido_last 'correr quitarRuidoPandero al ultimo video' \
               $HOME/monoliths-hm/audio-volume-high.png quitar_beep 'Quitar sonido BEEP' \
               $HOME/monoliths-hm/audio-volume-high.png mute_unmute_literatura 'Poner en mute el sistema de lectura' \
               $HOME/monoliths-hm/view-on.png invertir_colores 'Invertir colores de pantalla' \
               $HOME/monoliths-hm/view-on.png invertir_blancoynegro 'Invertir blanco y negro en pantalla' \
               $HOME/monoliths-hm/audio-volume-high.png volume 'Panel de volumen alsamixer' \
               $HOME/monoliths-hm/appointment-soon.png hora_y_aviso 'Mostrar/Ocultar Hora y type-to-move-cursor' \
               $HOME/monoliths-hm/cpu.png cpu_frio_powersave 'CPU en su mínimo consumo' \
               $HOME/monoliths-hm/view-on.png siempre_encendido 'Para no apagar pantalla' \
               $HOME/monoliths-hm/view-on.png Normal_YouTube 'YouTube normal en el navegador chromium' \
               $HOME/monoliths-hm/input-keyboard.png inhabilitar_caps 'Inhabilitar Bloq Mayus funcionamiento con Bluetooth' \
               $HOME/monoliths-hm/input-keyboard.png habilitar_caps 'Habilitar Bloq Mayus modo normal' \
               $HOME/monoliths-hm/input-keyboard.png teclas_rapidas 'Teclas rapidas para expertos' \
               $HOME/monoliths-hm/input-keyboard.png teclas_lentas 'Teclas lentas para novatos' \
               $HOME/monoliths-hm/input-keyboard.png latam 'Teclas Latam' \
               $HOME/monoliths-hm/input-keyboard.png de 'Teclas Deutsch' \
               $HOME/monoliths-hm/input-keyboard.png es 'Teclas Spain' \
               $HOME/monoliths-hm/input-keyboard.png us 'Teclas US' \
               $HOME/monoliths-hm/input-keyboard.png terminal 'Lxterminal' \
               $HOME/monoliths-hm/input-keyboard.png antigravity 'Antigravity' \
               $HOME/monoliths-hm/media-playlist-add.png luz_para_oscuro 'Optimizar luz pantalla' \
               $HOME/monoliths-hm/media-playlist-add.png luz_para_claro 'Optimizar luz pantalla' \
               $HOME/monoliths-hm/cpu.png cpu_bajo_consumo 'CPU en bajo consumo' \
               $HOME/monoliths-hm/network-bluetooth-connected.png bluetooth_manage 'Encender bluetooth' \
               $HOME/monoliths-hm/applications-internet.png red_interna 'Conectar a la vpn ...o red interna de pandero' \
               $HOME/monoliths-hm/emacs.png emacs 'Normal emacs' \
               $HOME/monoliths-hm/emacs_develop.png emacs_develop 'Develop emacs' \
               $HOME/monoliths-hm/system-file-manager.png screen_switch 'Personal script switch on tree sizes of screen resolution' \
               $HOME/monoliths-hm/media-playlist-add.png verme 'Mpv para verme' \
               $HOME/monoliths-hm/media-playlist-add.png rec_1_min 'Simplescreenrecorder 1 minute' \
               $HOME/monoliths-hm/media-playlist-add.png rec_2_min 'Simplescreenrecorder 2 minute' \
               $HOME/monoliths-hm/media-playlist-add.png rec_6_min 'Simplescreenrecorder 6 minute' \
               $HOME/monoliths-hm/media-playlist-add.png rec_20_min 'Simplescreenrecorder 20 minute' \
               $HOME/monoliths-hm/media-playlist-add.png rec_30_min 'Simplescreenrecorder 30 minute' \
               $HOME/monoliths-hm/system-reboot.png do_reboot 'Reiniciar' \
               $HOME/monoliths-hm/system-reboot.png sync_git 'Sincronizar git' \
               $HOME/monoliths-hm/view-on.png chromium 'Web browser in chromium' \
               $HOME/monoliths-hm/view-on.png chromium_tmp 'new Web browser in chromium' \
               $HOME/monoliths-hm/view-on.png firefox 'Web browser firefox' \
               $HOME/monoliths-hm/view-on.png firefox_tmp 'tmp Web browser in firefox' \
               $HOME/monoliths-hm/view-on.png firefox_jira_ticket 'Jira for tickets user on Web browser firefox' \
               $HOME/monoliths-hm/view-on.png firefox_looker_jira 'Looker and Jira user on Web browser firefox' \
               $HOME/monoliths-hm/media-playlist-add.png counter_seconds 'Pregunta por cantidad de segundos para mostrar una barra de progreso' \
               $HOME/monoliths-hm/media-playlist-add.png counter_minutes 'Pregunta por cantidad de minutos para mostrar una barra de progreso especial' \
               $HOME/monoliths-hm/media-playlist-add.png exercises_fast 'Fast Preparation for pronunciation' \
               $HOME/monoliths-hm/media-playlist-add.png exercises_nice 'Nice Preparation for pronunciation' \
               $HOME/monoliths-hm/input-mouse.png touchpad_fast 'Duplicar la velocidad del touchpad' \
               --button='Ejecutar ...o tipea Enter:0' \
               --separator=':'
          )

    # Verificar si el usuario canceló
    if [ "$?" != '0' ] || [ -z "$OPCION" ]; then
        continue
    fi

    # Extraer la primera columna (el comando)
    COMANDO=$(echo "$OPCION" | cut -d: -f2)

    # Ejecutar según la opción
    case "$COMANDO" in
        tarea_aurelia)
            if ! ping -c 1 google.com > /dev/null; then
                sleep 1
            fi
            chromium --app="$(get_secret 1)" &
            ;;
        invertir_colores)
            if [ -f /tmp/_xcalib_working ]; then
                rm /tmp/_xcalib_working
            fi
            sleep 0.5 && xcalib -i -a &
            ;;
        invertir_blancoynegro)
            if pgrep picom > /dev/null; then
                killall picom
            else
                sleep 0.9 && picom --backend glx --no-fading-openclose --inactive-opacity=1.0 --active-opacity=1.0 --frame-opacity=1.0 --no-use-damage --window-shader-fg $HOME/monoliths-llm/blackandwhite.frag &
            fi
            ;;
        hora_y_aviso)
            if [ -f $HOME/.stop_personal_osdx ]; then
                rm $HOME/.stop_personal_osdx
            else
                touch $HOME/.stop_personal_osdx
            fi
            ;;
        volume)
            xterm -fa Monospace -bg white -fg black -xrm 'XTerm*color0: white' -xrm 'XTerm*color7: black'  -e 'alsamixer -c 0 -V all' &
            ;;
        ppf_fe)
	    if cat ~/amd64gnu+linux/front-end.sh | grep 'MODO="mock"' > /dev/null && \
		    cat ~/amd64gnu+linux/pandero-portal-frontend.sh | grep 'MODO="mock"' > /dev/null; then
		yad --title="Modo mock" \
		    --text="\Estas en modo mock no olvides levantar el ~/mock_base_in_GCCGO\n" \
		    --window-icon="video-display" \
		    --center \
		    --width=350 \
		    --button="Aceptar:0"
	    else
		xterm -fa Monospace -bg white -fg black -xrm 'XTerm*color0: white' -xrm 'XTerm*color7: black'  -e 'doas openfortivpn -c ~/.ofv.conf' &
	    fi
            xterm -fa Monospace -bg white -fg black -xrm 'XTerm*color0: white' -xrm 'XTerm*color7: black'  -e 'cd ; cd amd64gnu+linux ; dash pandero-portal-frontend.sh' &
            xterm -fa Monospace -bg white -fg black -xrm 'XTerm*color0: white' -xrm 'XTerm*color7: black'  -e 'cd ; cd amd64gnu+linux ; dash front-end.sh' &
            ;;
        mute_unmute_literatura)
            if [ -f $HOME/literatura/script-literatura.sh ]; then
                if ! cat $HOME/literatura/script-literatura.sh | grep "#MUTE=''" > /dev/null; then
                    sed -i "s/MUTE=''/#MUTE=''/" $HOME/literatura/script-literatura.sh
                else
                    sed -i "s/#MUTE=''/MUTE=''/" $HOME/literatura/script-literatura.sh
                fi
            fi
            ;;
        quitar_beep)
            if command -v doas >/dev/null 2>&1; then
                doas rmmod pcspkr 2>/dev/null || true
            else
                sudo rmmod pcspkr 2>/dev/null || true
            fi
            ;;
        luz_para_oscuro)
            for a in $(xrandr | grep ' connected' | awk '{print $1}'); do
                xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.2
            done
            ;;
        luz_para_claro)
            for a in $(xrandr | grep ' connected' | awk '{print $1}'); do
                xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.4
            done
            ;;
        bluetooth_manage)
            blueman-manager &
            ;;
        verme)
            ffplay -fflags nobuffer -flags low_delay -framedrop \
                   -vf 'crop=250:530:(iw-250)/2:(ih-530)/2,hflip' /dev/video0 &
            ;;
        cpu_frio_powersave)
            dash $HOME/monoliths-llm/enfriar-asus.sh &
            ;;
        siempre_encendido)
            xset s off && xset s noblank && xset -dpms
            ;;
        literatura)
            cd $HOME/literatura && dash literatura.sh
            ;;
        literatura_to_es)
            cd $HOME/literatura-to-es && dash literatura.sh
            ;;
        cpu_bajo_consumo)
            dash $HOME/battery-saver.sh &
            ;;
        inhabilitar_caps)
            setxkbmap -option caps:none
            echo 'caps:none' > /tmp/caps_mode.my
            ;;
        chromium)
	    # 1. Obtener la hora actual en formato HHMM
	    # Usamos sed para quitar ceros iniciales y evitar que el shell lo interprete como octal
	    hora_actual=$(date +%H%M | sed 's/^0*//')
	    # Si la hora es 00:00, el resultado queda vacío, lo reseteamos a 0
	    : "${hora_actual:=0}"

	    # =========================================================================
	    # VALIDACIÓN DE HORARIO
	    # =========================================================================
	    # POSIX: Usamos [ ] estándar. Los operadores -ge y -lt funcionan bien con enteros.
	    # Nota: 8:45 AM se evalúa como 845.

	    fuera_horario=0

	    if [ "$hora_actual" -ge 1800 ] || [ "$hora_actual" -lt 845 ]; then
		fuera_horario=1
	    elif [ "$hora_actual" -ge 1300 ] && [ "$hora_actual" -lt 1400 ]; then
		fuera_horario=1
	    fi

	    if [ "$fuera_horario" -eq 1 ]; then
		echo "Fuera de horario laboral o en hora de almuerzo. Abriendo navegador vacío."
		chromium &
	    else
		# =========================================================================
		# CONFIGURACIÓN DE URLS (DENTRO DE HORARIO)
		# =========================================================================
		URLS="$(get_secret 2) https://gmail.com https://calendar.google.com/calendar/u/0/r $(get_secret 4) https://gemini.google.com/u/1/app"

		# Evaluar si es hora del Meet extra (9:30 AM a 10:00 AM)
		if [ "$hora_actual" -ge 930 ] && [ "$hora_actual" -lt 1000 ]; then
		    URLS="$(get_secret 3) $URLS"
		fi

		# 5. Ejecutar chromium con las URLs
		# No usamos comillas en $URLS para que el shell las pase como argumentos separados
		chromium --new-window $URLS &

		# Esperar un par de segundos
		sleep 2

		# =========================================================================
		# INTERFAZ YAD Y AUTOMATIZACIÓN
		# =========================================================================

		execute() {
		    # Paso 1: Ctrl+d (Micrófono)
		    sleep 2
		    echo "Presionando Ctrl+d para apagar micrófono" | osd_cat --align=center --pos=bottom --offset=50 --color=cyan --delay=1 &
		    xdotool key ctrl+d
		    
		    # Paso 2: Ctrl+e (Cámara)
		    sleep 1
		    echo "Presionando Ctrl+e para apagar cámara" | osd_cat --align=center --pos=bottom --offset=50 --color=cyan --delay=1 &
		    xdotool key ctrl+e
		    
		    # Paso 3: Return (Ingresar)
		    sleep 1
		    echo "Presionando Return para ingresar" | osd_cat --align=center --pos=bottom --offset=50 --color=green --delay=1 &
		    xdotool key Return
		}

		# Lanzamos YAD directamente. Se pausará el script hasta que elijas una opción.
		yad --title="Auto-Ingreso Meet" \
		    --text="\nPresione <b>Return</b> para auto ingresar al meet...\no <b>Esc</b> para no hacer nada\n" \
		    --window-icon="video-display" \
		    --center \
		    --width=350 \
		    --button='Aceptar:0' \
		    --button='Cancelar:1'

		# Guardamos el código de salida (exit status) del comando yad
		YAD_STATUS=$?

		# Evaluamos qué botón se presionó
		if [ "$YAD_STATUS" -eq 0 ]; then
		    # Se presionó Aceptar (devuelve código 0)
		    ( sleep 1 && execute ) &
		else
		    # Se presionó Cancelar (código 1) o se cerró la ventana con Esc (código 252)
		    echo "Ingreso automático cancelado."
		fi
	    fi
            ;;
        firefox)
            firefox &
            ;;
	chromium_tmp)
            mkdir -p $HOME/.chromium-new-profile-$(date +%s) && chromium --user-data-dir=$HOME/.chromium-new-profile-$(date +%s) &
            ;;
        firefox_tmp)
            mkdir -p $HOME/.firefox-new-profile-$(date +%s) && firefox --profile $HOME/.firefox-new-profile-$(date +%s) &
            ;;
        firefox_jira_ticket)
            mkdir -p $HOME/.firefox-jira-ticket-profile && firefox --profile $HOME/.firefox-jira-ticket-profile &
            ;;
        firefox_looker_jira)
            mkdir -p $HOME/.firefox-looker-jira-profile && firefox --profile $HOME/.firefox-looker-jira-profile &
            ;;
        red_interna)
            xterm -fa Monospace -bg white -fg black -xrm 'XTerm*color0: white' -xrm 'XTerm*color7: black'  -e 'doas openfortivpn -c ~/.ofv.conf' &
            ;;
        teclas_rapidas)
            while true; do
                xset r rate 150 110
                sleep 1
            done &
            ;;
        habilitar_caps)
            setxkbmap -option
            echo '' > /tmp/caps_mode.my
            ;;
        teclas_lentas)
            while true; do
                xset r rate 140 60
                sleep 1
            done &
            ;;
        screen_switch)
            size1='640 360'
            size2='1024 576'
            size3='1920 1080'

            if cat $HOME/.actual_screen_size | grep -q 1920 > /dev/null; then
                echo -n "$size2" > $HOME/.actual_screen_size
            elif cat $HOME/.actual_screen_size | grep -q 1024 > /dev/null; then
                echo -n "$size1" > $HOME/.actual_screen_size
            else
                echo -n "$size3" > $HOME/.actual_screen_size
            fi

            size=$(cat $HOME/.actual_screen_size)

            MODELINE_NAME=$(cvt $(echo -n "$size")  60 | awk '/Modeline/ {print $2}')
            MODELINE_PARAMS=$(cvt $(echo -n "$size") 60 | awk '/Modeline/ {for(i=3;i<=NF;i++) printf $i " "; print ""}')

            xrandr --newmode "$MODELINE_NAME" $MODELINE_PARAMS
            xrandr --addmode eDP-1 "$MODELINE_NAME"
            xrandr --output eDP-1 --mode "$MODELINE_NAME"

            sleep 0.1
            killall xbattmon
            sleep 0.1
            xbattmon &
            ;;
        do_reboot)
            if command -v doas >/dev/null 2>&1; then
                doas reboot
            else
                sudo reboot
            fi
            ;;
        latam|de|us|es)
            echo "$COMANDO" > /tmp/layout.my
            ;;
        emacs)
            MIXEDCOLOR='-mm -fg white -bg black'
            MIXEDCOLOR=''
            emacs $MIXEDCOLOR -mm &
            ;;
        read_line_by_line)
            emacs -mm -q -Q --file=$HOME/monoliths-llm/text_english_training.el --eval='(eval-buffer)' &
            if ! doas dmesg 2>/dev/null | grep -q thinkpad; then
                audacity &
            fi
            ;;
        emacs_develop)
            MIXEDCOLOR='-mm -fg white -bg black'
            MIXEDCOLOR=''
            emacs $MIXEDCOLOR -q -Q &
            ;;
        sync_git)
            cd && dash saravia &
            ;;
        Normal_YouTube)
            chromium --new-window='https://youtube.com' &
            ;;
        rec_1_min|rec_2_min|rec_6_min|rec_20_min|rec_30_min)
            MINUTES=$(echo $COMANDO | tr -cd '0-9')
            dash $HOME/monoliths-hm/message_img.sh "$MINUTES minute$([ $MINUTES -eq 1 ] && echo -n '' || echo -n s) → $(cat $HOME/.title)" &
            dash $HOME/monoliths-llm/rec-to-certain-min.sh $MINUTES &
            TOTALSECONDS=$(($MINUTES * 60))
            SECONDS=0
            # -lt question: are differents?
            while [ $SECONDS -lt $TOTALSECONDS ]; do
                [ -e /tmp/.stop ] && break
                SECONDS=$(($SECONDS + 1))
                sleep 1
            done
            sleep 10
            ;;
        watch_last)
            latest_video=$(ls -t $HOME/simplescreenrecorder-*.mkv 2>/dev/null | head -n 1)
            if [ -n "$latest_video" ]; then
                mpv "$latest_video" &
            fi
            ;;
        quitar_ruido_last)
            cd $HOME
            latest_video=$(ls -t simplescreenrecorder-*.mkv 2>/dev/null | head -n 1)
            if [ -n "$latest_video" ]; then
                dash $HOME/quitarRuidoPandero "$latest_video"
            fi
            ;;
        counter_seconds)
            dash $HOME/monoliths-llm/simple_second_counter-N-yad.sh &
            ;;
        counter_minutes)
            dash $HOME/monoliths-llm/special_minute_counter_xtimemon-N-yad.sh &
            ;;
        exercises_nice)
            dash $HOME/monoliths-llm/exercises_nice.sh
            ;;
        exercises_fast)
            dash $HOME/monoliths-llm/exercises_fast.sh
            ;;
        terminal)
            lxterminal &
            ;;
        antigravity)
            xterm -fa Monospace -bg white -fg black -xrm 'XTerm*color0: white' -xrm 'XTerm*color7: black'  -e 'sudo apt update; sudo apt upgrade --yes'
            bash -c 'antigravity &'
            ;;
        touchpad_fast)
            DEVICE="ELAN0791:00 04F3:30FD Touchpad"
            # Ajuste de velocidad para driver Synaptics
            xinput --set-prop "$DEVICE" "Synaptics Move Speed" 2.0 4.0 0.15 0.0
            echo "Velocidad del touchpad aumentada (Synaptics)."
            ;;
        *)
            # Opción no reconocida
            continue
            ;;
    esac

    # Pequeña pausa antes de mostrar el menú nuevamente
    sleep 0.1
done
