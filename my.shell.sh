#!/bin/dash

PARAM="$1"

Laptop=$(doas dmesg 2>/dev/null | grep -q 'HP HP' && echo Asus || echo HP)
LaptopMin=$(doas dmesg 2>/dev/null | grep -q 'HP HP' && echo hp || echo asus)
if [ -z "$PARAM" ]; then
    echo '=== Lista de Opciones ==='
    echo ''
    echo '1) Configurar_Resolucion - Configurar pantalla a 1024x576 a 60Hz'
    echo '2) Atajos_Teclado - Iniciar demonio de atajos personalizados (xbindkeys)'
    echo '3) Sincronizar_Hora - Ajustar reloj del sistema mediante red (ntpd)'
    echo '4) Reloj_Pantalla - Mostrar un reloj permanente en la esquina'
    echo '5) Esperar_Monitores - Pausar 5 seg si se conectaron monitores externos'
    echo '6) Arranque_Thinkpad - Ejecutar inicio automatico para Thinkpad (BT/Scripts)'
    echo '7) Auto_Teclado - Forzar Latam continuamente y apagar BloqMayus'
    echo '8) Resolucion_Consola - Reiniciar PC para arreglar el tamaño de letras en terminal (TTY)'
    echo '9) Calibrar_Trackball - Acelerar un poco mas la bola del TrackBall Mouse'
    echo '10) Monitor_Bateria - Seguimiento del nivel y tiempo de bateria en OSD'
    echo '11) Alternar_Aviso - Ocultar/Mostrar el aviso OSD de la hora permanentemente'
    echo '12) Control_Volumen - Abrir mezclador de sonido en terminal (Alsamixer)'
    echo '13) Silenciar_Pitos - Quitar sonido molesto de 'beep' del sistema (pcspkr)'
    echo '14) Rutina_Tracking_A - Trakear productivo mediante (xtimemon) de [10-13, 14-19]'
    echo '15) Rutina_Tracking_B - Trakear productivo mediante (xtimemon) de [10-12, 14-20]'
    echo '16) Rutina_Tracking_C - Trakear productivo mediante (xtimemon) de [09-13, 14-18]'
    echo '17) Rutina_Tracking_D - Trakear productivo mediante (xtimemon) de [09-12, 14-19]'
    echo '18) Rutina_Tracking_E - Trakear productivo mediante (xtimemon) de [09-12, 15-20]'
    echo '19) Modo_Noche_Monitor - Reducir todo el brillo a 0.2 para evitar fatiga visual'
    echo '20) Modo_Dia_Monitor - Subir iluminacion a 0.4 para habitaciones muy claras'
    echo '21) Audio_Por_HDMI - Enrutar sonido al televisor (HDMI) y abrir Firefox'
    echo '22) Prender_Bluetooth - Iniciar administradores y activar conectividad Bluetooth'
    echo '23) Apagar_Bluetooth - Detener administrador dbus y apagar consumo Bluetooth'
    echo '24) Camara_Espejo - Proyectar webcam frontal en esquina inferiar e imagen invertida'
    echo '25) Rutina_Tracking_F - Trakear extrema mañana usando xtimemon desde [07-09]'
    echo '26) Apagar_Luz_Wifi - Apagar el led molesto del dispositivo tplink usb'
    echo '27) Bloquear_Apagado - Evitar que la pantalla se vuelva negra tras inactividad'
    echo '28) Estudio_Nativo - Iniciar programa de literatura en idioma original'
    echo '29) Estudio_Traducido - Iniciar programa de literatura traducido al español'
    echo '30) Desactivar_BloqMayus - Inhabilitar la tecla de Mayusculas para comodidad al escribir'
    echo '31) Visitar_Mi_Guia - Visualizar atajos FVWM base leyendo el html en navegador'
    echo '32) Servicio_VPN - Comenzar conectividad virtual privada desde un buffer de emacs'
    echo '33) Velocidad_Experto - Hacer que la repeticion de teclas al presionar sea rapidisima'
    echo '34) Ocultar_Barra_Bat - Cerrar la barra inferior verde/roja de bateria'
    echo '35) Activar_BloqMayus - Restaurar funcionamiento normal de tecla Mayusculas'
    echo '36) Velocidad_Novato - Repetir mas lento cada letra en pulsacion sostenida'
    echo '37) Mostrar_Barra_Bat - Volver a iniciar la barra de nivel de bateria en pantalla'
    echo '38) Cerrar_Mi_Sesion - Matar aplicaciones abiertas y botar del servidor X a login manager'
    echo '39) Apagar_Equipo - Cerrar demonios y apagar el equipo por hardware permanentemente'
    echo '40) Configurar_Pantallas - Lanzar 'Arandr' para ajustar visualmente los monitores conectados'
    echo '41) Reiniciar_Sistema - Hacer un apagado controlado y encender inmediatamente el computador'
    echo '42) Layout_Latino_America - Cambiar mapeo del teclado a disposicion usual de America Latina'
    echo '43) Lanzar_Emacs_Normal - Iniciar instancia principal y completa del editor de texto Emacs'
    echo '44) Pronunciacion - Practicar lectura linea por linea con voz en Emacs (TTS)'
    echo '45) Layout_Aleman - Cambiar el layout del teclado a distribucion de Alemania (QWERTZ)'
    echo '46) Layout_Americano - Cambiar mapeo a distribucion de Ingles USA'
    echo '47) Layout_Espana - Cambiar del reclado a disposicion clasica de España'
    echo '48) Lanzar_Emacs_Desarrollo - Carga rapida de Emacs vacio con fondo negro visualmente'
    echo '49) Asistente_ChatGPT - Abrir aplicacion web oficial de chat bot inteligente en Chromium'
    echo '50) Respaldar_Archivos - Enviar modificacion locales a backup usando codigo git propio'
    echo '51) Abrir_YouTube - Lanzar pagina de YouTube usando el navegador integrado'
    echo '52) Grabar_Video_1m - Hacer un clip grabando mi escritorio solo durante un minuto continuo'
    echo '53) Grabar_Video_2m - Capturar de pantalla grabando por dos minutos seguido'
    echo '54) Grabar_Video_6m - Para grabar segmentos medios equivalentes a 6 minutos'
    echo '55) Grabar_Video_20m - Capturas grandes sin interrupcion en un periodo de viente min.'
    echo '56) Grabar_Video_30m - Extremo para capturar clase por el periodo de media hora'
    echo '57) Ver_Ultima_Grabacion - Reproducir automaticamente tu ultimo video grabado (MPV)'
    echo '58) Reloj_Segundos - Lanzar barra de progreso visual pidiendo cuenta en segundos primero'
    echo '59) Reloj_Minutos - Barra especifica pidiendo cuenta grande en formato de minutos directos'
    echo '60) Monitor_Colores_Invertidos - Invierte los colores de la pantalla para evitar forzar la vista'
    echo '61) Monitor_Colores_Monocromo - Pone la pantalla en monocromatico para evitar forzar la vista'
    echo '62) Quitar_Ruido_Ultima_Grabacion - Va a la ultima grabacion y con algunos clics quitas el ruido de la ultima grabacion'
    echo '63) Evitar_Incremento_Temperatura - Pone el CPU en modo controlado para evitar el incremento de temperatura'
    echo '64) Firefox_Ticket_Luis - Ingresa en firefox para registrar tickets de Luis a.'
    echo '65) Firefox_Looker_Jira - Ingresa en firefox para revisar el Looker y el Jira'
    echo '66) Estudio_Nativo_Silenciado - Alterna estudiar nativo entre en silencio y con sonido'
    echo '67) Apagar_Touchpad - Alterna entre apagar y encender Touchpad'
    echo '68) Xbindkeys_Touchpad_Switcher - Usar Alt+1/Alt+2 para controlar Touchpad via xbindkeys'
    echo '69) Touchpad_Fast - Duplicar la velocidad del touchpad'
    echo '70) Chromium_LuisAProfile - Profile para gestionar tickets de LuisA'
    echo '71) Chromium_GuiosepTProfile - Profile para gestionar tickets de GuiosepT'
    echo '72) Contar_Horas - Time counter'
    echo '73) GChrome_Profile_Ticket_ERC - Perfil para registrar ticket Evaluacion de riesgo crediticio'
    echo '74) GChrome_Profile_Tmp - Perfil clean tmp'
    echo "75) Emwm_$Laptop - Xephyr"
    echo "76) Emacs_$Laptop - emacs $Laptop"
    echo '77) Relax_Energy - Perfil powersave brutal'
    echo "78) Tmux_$Laptop - Tmux $Laptop"
    echo '79) Tmux_USA - Tmux USA'
    echo '80) Luz_Off_Pantalla - apagar la luz de la pantalla'
    echo '81) Max_Energy - Perfil non-powersave brutal'
    echo '82) Ver_Log - Ver log del jira'
    echo '83) Google_Chrome_No_Inhibit - Mantener tty encendida'
    echo '84) Firefox_Tmp - Firefox tmp'
    echo ''
fi

# --- Manejo de Parámetros ---
USER_INPUT=""

if [ -n "$PARAM" ]; then
    if echo "$PARAM" | grep -q '^[0-9]\+$'; then
        # Búsqueda por número directo dentro de los comandos 'echo'
        MATCH=$(grep "echo '$PARAM)" "$0" | head -n 1 | sed "s/.*echo '//; s/'.*//")
        if [ -n "$MATCH" ]; then
            printf "\nDesea seleccionar esta opcion? \n"
            printf "$MATCH [S/n] "
            read CONFIRM
            case "$CONFIRM" in
                ""|[Ss]*) USER_INPUT="$PARAM" ;;
                *) echo "Cancelado."; exit 0 ;;
            esac
        else
            echo "No se encontró la opción número $PARAM."
            exit 1
        fi
    else
        # Búsqueda por texto (insensible a mayúsculas) dentro de los echo
        # Filtramos para obtener solo el texto de la opción
        MATCHES=$(grep -i "echo '[0-9]\+) .*$PARAM" "$0" | sed "s/.*echo '//; s/'.*//")
        NUM_MATCHES=$(echo "$MATCHES" | grep -v "^$" | wc -l)

        if [ "$NUM_MATCHES" -eq 0 ]; then
            echo "No se encontró ninguna opción que coincida con '$PARAM'."
            exit 1
        elif [ "$NUM_MATCHES" -eq 1 ]; then
            printf "\nDesea seleccionar esta opcion? \n"
            printf "$MATCHES [S/n] "
            read CONFIRM
            case "$CONFIRM" in
                ""|[Ss]*) USER_INPUT=$(echo "$MATCHES" | cut -d')' -f1) ;;
                *) echo "Cancelado."; exit 0 ;;
            esac
        else
            echo "Se encontraron varias opciones para '$PARAM':"
            echo "$MATCHES"
            printf "\nSe encontraron varias opciones. Ingresa el número para escoger (o Enter para cancelar): "
            read SELECTION
            if [ -z "$SELECTION" ]; then
                echo "Cancelado."
                exit 0
            fi
            # Validar que el número ingresado esté en el set de resultados encontrados
            if echo "$MATCHES" | grep -q "^$SELECTION)"; then
                USER_INPUT="$SELECTION"
            else
                echo "Error: La opción '$SELECTION' no es válida para la búsqueda '$PARAM'."
                exit 1
            fi
        fi
    fi
else
    # Comportamiento original si no hay parámetros
    printf 'Elige un número o escribe el comando: '
    read USER_INPUT
fi

case "$USER_INPUT" in
    1|Configurar_Resolucion)
        MODELINE_NAME=$(cvt 1024 576 60 | awk '/Modeline/ {print $2}')
        MODELINE_PARAMS=$(cvt 1024 576 60 | awk '/Modeline/ {for(i=3;i<=NF;i++) printf $i " "; print ""}')
        xrandr --newmode $MODELINE_NAME $MODELINE_PARAMS
        xrandr --addmode eDP-1 $MODELINE_NAME
        xrandr --output eDP-1 --mode $MODELINE_NAME
        ;;
    2|Atajos_Teclado)
        xbindkeys
        ;;
    3|Sincronizar_Hora)
        doas ntpd
        ;;
    4|Reloj_Pantalla)
        if [ ! -f /tmp/clock_is_run_already.pid ]; then
            while true; do
                if [ ! -f $HOME/.stop_personal_osdx ]; then
                    touch /tmp/clock_is_run_already.pid
                    dash $HOME/monoliths-hm/optime.personal_osdx.sh
                fi
                sleep 0.1
            done
        fi
        ;;
    5|Esperar_Monitores)
        if xrandr | grep -q ' DP-1 connected' ||
                xrandr | grep -q 'DP-2 connected' ||
                xrandr | grep -q 'HDMI-1 connected'; then
            sleep 5s
        fi
        ;;
    6|Arranque_Thinkpad)
        if doas dmesg | grep thinkpad > /dev/null; then
            sleep 2 && cd && bash literatura.sh && dash $HOME/monoliths-hm/autoinit.sh
            doas service dbus start; doas service bluetooth start
            ( sleep 3 && echo -e "power on\nexit" | bluetoothctl )
        fi
        ;;
    7|Auto_Teclado)
        echo 'latam' > /tmp/layout.my
        echo 'caps:none' > /tmp/caps_mode.my
        while true; do
            CAPS_MODE=$(cat /tmp/caps_mode.my)
            LAYOUT=$(cat /tmp/layout.my)
            setxkbmap "$LAYOUT"
            setxkbmap -option "$CAPS_MODE"
            sleep 1
        done
        ;;
    8|Resolucion_Consola)
	echo 'Resolucion_Consola ... no works'
        # ( [ -f /etc/default/grub.normal ] || doas cp /etc/default/grub /etc/default/grub.normal ) && \
        #     cat /etc/default/grub | grep -q '800x600' && \
        #     ( doas cp /etc/default/grub.normal /etc/default/grub ) || \
        #         ( echo 'GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"' | doas tee -a /etc/default/grub && \
        #               echo 'GRUB_GFXMODE=800x600' | doas tee -a /etc/default/grub && \
        #               echo 'GRUB_GFXPAYLOAD_LINUX=keep' | doas tee -a /etc/default/grub ) && \
        #             ( doas grub-mkconfig -o /boot/grub/grub.cfg && doas reboot )
        ;;
    9|Calibrar_Trackball)
        while true; do
            ID=$(xinput list | grep 'SONiX Perixx Trackball Keyboard Mouse' | grep -o 'id=[0-9]*' | cut -d= -f2)
            PROPS=$(xinput list-props "$ID")
            echo "$PROPS" | grep -q 'libinput Accel Speed' && \
                ( xinput --set-prop "$ID" 'libinput Accel Speed' -1.0; xinput --set-prop "$ID" 'libinput Accel Profile Enabled' 1 0 ) || \
                    ( xinput --set-prop "$ID" 'Device Accel Constant Deceleration' --type=float 4.0; \
                      xinput --set-prop "$ID" 'Device Accel Adaptive Deceleration' --type=float 4.0; \
                      xinput --set-prop "$ID" 'Device Accel Velocity Scaling' --type=float 4.0 )
            sleep 1
        done
        ;;
    10|Monitor_Bateria)
        if [ ! -f /tmp/clock_is_run_already.pid ]; then
            doas ntpd
            echo "$(date)" > $HOME/.start_at.log
            (
                while true; do
                    touch /tmp/clock_is_run_already.pid
                    echo "$(date)" > $HOME/.track_at.log
                    printf "B.T. \n\n%s\n%s" "$(date +'%T')" "$(wmctrl -l | grep -q 'ctrl+shift releases' && echo 'Xephyr quit Ctrl+Shift' || ( grep -q 'NOT MOUSE' $HOME/.xbindkeysrc && echo 'Keyboard quit Alt+2' || echo 'Mouse quit Alt+1' ))" | osd_cat --pos=top --align=right --offset=50 --color=green --shadow=1 --delay=1 --lines=4 --font='-misc-fixed-*-*-*-*-30-*-*-*-*-*-*-*'
                    sleep 0.5
                done
            )
        fi
        ;;
    11|Alternar_Aviso)
        [ -f "$HOME/.stop_personal_osdx" ] && rm "$HOME/.stop_personal_osdx" || touch "$HOME/.stop_personal_osdx"
        ;;
    12|Control_Volumen)
	export DISPLAY=:0
        xterm -e 'alsamixer'
        ;;
    13|Silenciar_Pitos)
        doas rmmod pcspkr
        ;;
    14|Rutina_Tracking_A)
        HOUR=$(date +%H); if [ $HOUR -ge 10 -a $HOUR -lt 13 ]; then ( xtimemon -S 10:00 -E 13:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 19 ]; then ( xtimemon -S 14:00 -E 19:00 -p top ); fi
        ;;
    15|Rutina_Tracking_B)
        HOUR=$(date +%H); if [ $HOUR -ge 10 -a $HOUR -lt 12 ]; then ( xtimemon -S 10:00 -E 12:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 20 ]; then ( xtimemon -S 14:00 -E 20:00 -p top ); fi
        ;;
    16|Rutina_Tracking_C)
        HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 13 ]; then ( xtimemon -S 09:00 -E 13:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 18 ]; then ( xtimemon -S 14:00 -E 18:00 -p top ); fi
        ;;
    17|Rutina_Tracking_D)
        HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 12 ]; then ( xtimemon -S 09:00 -E 12:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 19 ]; then ( xtimemon -S 14:00 -E 19:00 -p top ); fi
        ;;
    18|Rutina_Tracking_E)
        HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 12 ]; then ( xtimemon -S 09:00 -E 12:00 -p top ); elif [ $HOUR -ge 15 -a $HOUR -lt 20 ]; then ( xtimemon -S 15:00 -E 20:00 -p top ); fi
        ;;
    19|Modo_Noche_Monitor)
        for a in $(xrandr | grep ' connected' | awk '{print $1}'); do xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.2; done
        ;;
    20|Modo_Dia_Monitor)
        for a in $(xrandr | grep ' connected' | awk '{print $1}'); do xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.4; done
        ;;
    21|Audio_Por_HDMI)
        doas service tor start && doas service sndiod start && sleep 1 && sndiod -f rsnd/0,3 && firefox > /dev/null 2>&1
        ;;
    22|Prender_Bluetooth)
        doas service dbus start; doas service bluetooth start
        ;;
    23|Apagar_Bluetooth)
        doas service dbus stop; doas service bluetooth stop
        ;;
    24|Camara_Espejo)
        ffplay -fflags nobuffer -flags low_delay -framedrop -vf 'crop=250:530:(iw-250)/2:(ih-530)/2,hflip' /dev/video0
        ;;
    25|Rutina_Tracking_F)
        HOUR=$(date +%H); if [ $HOUR -ge 7 -a $HOUR -lt 10 ]; then ( xtimemon -S 7:20 -E 9:20 -p top ); fi
        ;;
    26|Apagar_Luz_Wifi)
        ( echo 0 | doas tee /sys/class/leds/ath9k_htc-phy1/brightness || echo 0 | doas tee /sys/class/leds/ath9k_htc-phy0/brightness )
        ;;
    27|Bloquear_Apagado)
        xset s off && xset s noblank && xset -dpms
        ;;
    28|Estudio_Nativo)
        cd $HOME/literatura && dash literatura.sh
        ;;
    29|Estudio_Traducido)
        cd $HOME/literatura-to-es && dash literatura.sh
        ;;
    30|Desactivar_BloqMayus)
        setxkbmap -option caps:none
        ;;
    31|Visitar_Mi_Guia)
        bash /usr/share/fvwm3/default-config/c || chromium
        ;;
    32|Servicio_VPN)
        emacs --eval='(ofv)'
        ;;
    33|Velocidad_Experto)
        while true; do
            xset r rate 150 110
            sleep 1
        done
        ;;
    34|Ocultar_Barra_Bat)
        killall xbattmon
        ;;
    35|Activar_BloqMayus)
        setxkbmap -option
        ;;
    36|Velocidad_Novato)
        while true; do
            xset r rate 140 60
            sleep 1
        done
        ;;
    37|Mostrar_Barra_Bat)
        xbattmon
        ;;
    38|Cerrar_Mi_Sesion)
        doas killall X
        ;;
    39|Apagar_Equipo)
        doas poweroff
        ;;
    40|Configurar_Pantallas)
        arandr
        ;;
    41|Reiniciar_Sistema)
        doas reboot
        ;;
    42|Layout_Latino_America)
        echo 'latam' > /tmp/layout.my
        while true; do
            LAYOUT=$(cat /tmp/layout.my)
            setxkbmap "$LAYOUT"
            sleep 1
        done
        ;;
    43|Lanzar_Emacs_Normal)
        emacs -mm
        ;;
    44|Pronunciacion)
        emacs -mm -q -Q --file=$HOME/monoliths-llm/text_english_training.el --eval='(eval-buffer)'
        if ! doas dmesg | grep thinkpad > /dev/null; then
            audacity
        fi
        ;;
    45|Layout_Aleman)
        echo 'de' > /tmp/layout.my
        while true; do
            LAYOUT=$(cat /tmp/layout.my)
            setxkbmap "$LAYOUT"
            sleep 1
        done
        ;;
    46|Layout_Americano)
        echo 'us' > /tmp/layout.my
        while true; do
            LAYOUT=$(cat /tmp/layout.my)
            setxkbmap "$LAYOUT"
            sleep 1
        done
        ;;
    47|Layout_Espana)
        echo 'es' > /tmp/layout.my
        while true; do
            LAYOUT=$(cat /tmp/layout.my)
            setxkbmap "$LAYOUT"
            sleep 1
        done
        ;;
    48|Lanzar_Emacs_Desarrollo)
        emacs -mm -fg white -bg black -q -Q
        ;;
    49|Asistente_ChatGPT)
        chromium --app='https://chatgpt.com'
        ;;
    50|Respaldar_Archivos)
        cd && dash saravia
        ;;
    51|Abrir_YouTube)
        chromium --app='https://youtube.com'
        ;;
    52|Grabar_Video_1m)
        dash $HOME/monoliths-llm/rec-to-certain-min.sh 1
        end=$((SECONDS + 1*60))
        while [ $SECONDS -lt $end ]; do
            [ -e /tmp/.stop ] && break
            sleep 1
        done
        sleep 10
        ;;
    53|Grabar_Video_2m)
        dash $HOME/monoliths-llm/rec-to-certain-min.sh 2
        end=$((SECONDS + 2*60))
        while [ $SECONDS -lt $end ]; do
            [ -e /tmp/.stop ] && break
            sleep 1
        done
        sleep 10
        ;;
    54|Grabar_Video_6m)
        dash $HOME/monoliths-llm/rec-to-certain-min.sh 6
        end=$((SECONDS + 6*60))
        while [ $SECONDS -lt $end ]; do
            [ -e /tmp/.stop ] && break
            sleep 1
        done
        sleep 10
        ;;
    55|Grabar_Video_20m)
        dash $HOME/monoliths-llm/rec-to-certain-min.sh 20
        end=$((SECONDS + 20*60))
        while [ $SECONDS -lt $end ]; do
            [ -e /tmp/.stop ] && break
            sleep 1
        done
        sleep 10
        ;;
    56|Grabar_Video_30m)
        dash $HOME/monoliths-llm/rec-to-certain-min.sh 30
        end=$((SECONDS + 30*60))
        while [ $SECONDS -lt $end ]; do
            [ -e /tmp/.stop ] && break
            sleep 1
        done
        sleep 10
        ;;
    57|Ver_Ultima_Grabacion)
        latest_video=$(ls -t "$HOME"/simplescreenrecorder-*.mkv 2>/dev/null | head -1)
        mpv "$latest_video"
        ;;
    58|Reloj_Segundos)
        dash $HOME/monoliths-llm/simple_second_counter_xterm-N-yad.sh
        ;;
    59|Reloj_Minutos)
        dash $HOME/monoliths-llm/special_minute_counter_xtimemon-N-yad.sh
        ;;
    60|Monitor_Colores_Invertidos)
        if [ -f /tmp/_xcalib_working ]; then
            rm /tmp/_xcalib_working
        fi
        sleep 0.5 && xcalib -i -a
	;;			   
    61|Monitor_Colores_Monocromo)
        if pgrep picom > /dev/null; then
            killall picom
        else
            sleep 0.9 && picom --backend glx --no-fading-openclose --inactive-opacity=1.0 --active-opacity=1.0 --frame-opacity=1.0 --no-use-damage --window-shader-fg $HOME/monoliths-llm/blackandwhite.frag
        fi
	;;
    62|Quitar_Ruido_Ultima_Grabacion)
	cd $HOME
        latest_video=$(ls -t simplescreenrecorder-*.mkv 2>/dev/null | head -n 1)
        if [ -n "$latest_video" ]; then
            dash $HOME/quitarRuidoPandero "$latest_video"
        fi
	;;
    63|Evitar_Incremento_Temperatura)
	dash "${HOME}/monoliths-llm/enfriar-${LaptopMin}.sh"
	;;
    64|Firefox_Ticket_Luis)
	mkdir -p $HOME/.firefox-jira-ticket-frontalunificado-profile && firefox --profile $HOME/.firefox-jira-ticket-frontalunificado-profile
	;;
    65|Firefox_Looker_Jira)
	mkdir -p $HOME/.firefox-looker-jira-profile && firefox --profile $HOME/.firefox-looker-jira-profile
	;;
    66|Estudio_Nativo_Silenciado)
	if cat  | grep "#  MUTE=''" > /dev/null; then
	    sed -i "s/  MUTE=''/#  MUTE=''/" $HOME/Literatur/script-literatura.sh
	    sed -i "s/  MUTE=''/#  MUTE=''/" $HOME/literatura/script-literatura.sh
	else
	    sed -i "s/#  MUTE=''/  MUTE=''/" $HOME/Literatur/script-literatura.sh
	    sed -i "s/#  MUTE=''/  MUTE=''/" $HOME/literatura/script-literatura.sh
	fi
	;;
    67|Apagar_Touchpad)
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
	    exit 1
	fi
	;;
    68|Xbindkeys_Touchpad_Switcher)
	# Buscar si existe el respaldo temporal
	TEMP_BACKUP=$(ls $HOME/.xbindkeys.*.tmp 2>/dev/null | head -n 1)

	if [ -n "$TEMP_BACKUP" ]; then
	    # Modo Restauración: Regresar al original
	    rm -f "$HOME/.xbindkeys"
	    mv "$TEMP_BACKUP" "$HOME/.xbindkeys"
	    killall xbindkeys 2>/dev/null
	    xbindkeys
	    echo "Configuración original de xbindkeys restaurada."
	else
	    # Modo Activación: Crear configuración temporal
	    TIMESTAMP=$(date +%s)
	    if [ -f "$HOME/.xbindkeys" ]; then
		mv "$HOME/.xbindkeys" "$HOME/.xbindkeys.$TIMESTAMP.tmp"
		echo "Respaldo creado: .xbindkeys.$TIMESTAMP.tmp"
	    fi

	    # Crear nueva config con Alt+1 (OFF) y Alt+2 (ON)
	    cat <<EOF > "$HOME/.xbindkeys"
# Touchpad Switcher Mode
"xinput disable 'ELAN0791:00 04F3:30FD Touchpad'"
    alt + 1

"xinput enable 'ELAN0791:00 04F3:30FD Touchpad'"
    alt + 2
EOF
	    killall xbindkeys 2>/dev/null
	    xbindkeys -f "$HOME/.xbindkeys"
	    echo "Modo Touchpad Switcher activado: Alt+1 (Apagar), Alt+2 (Encender)."
	fi
	;;
    69|Touchpad_Fast)
	DEVICE="ELAN0791:00 04F3:30FD Touchpad"
	# Usamos las propiedades de Synaptics detectadas (MinSpeed, MaxSpeed, AccelFactor)
	# Valores originales: 1.0 1.75 0.05 -> Duplicamos para mas rapidez
	xinput --set-prop "$DEVICE" "Synaptics Move Speed" 2.0 4.0 0.15 0.0
	echo "Velocidad del touchpad aumentada (Synaptics)."
	;;
    70|Chromium_LuisAProfile)
        mkdir -p $HOME/.chromium_luis_a_profile_tikets && google-chrome-stable --user-data-dir=$HOME/.chromium_luis_a_profile_tikets &
	;;
    71|Chromium_GuiosepTProfile)
        mkdir -p $HOME/.chromium_guiosep_profile_tikets && google-chrome-stable --user-data-dir=$HOME/.chromium_guiosep_profile_tikets &
	;;
    72|Contar_Horas)
        if [ ! -f /tmp/Contar_Horas_counter_is_run_already.pid ]; then
            while true; do
                if [ ! -f $HOME/.stop_personal_osdx ]; then
                    touch /tmp/Contar_Horas_counter_is_run_already.pid
                    bash $HOME/monoliths-hm/hour_big_count_ascii.sh
                fi
                sleep 0.1
            done
        fi
        ;;
    73|GChrome_Profile_Ticket_ERC)
	folder='chromium-new-profile-ticket-erc'; mkdir -p "$HOME/.$folder" && google-chrome-stable --user-data-dir="$HOME/.$folder" &
	;;
    74|GChrome_Profile_Tmp)
	tmpfolder='/tmp/chromium-new-profile-tmp'; mkdir -p "$tmpfolder" && google-chrome-stable --user-data-dir="$tmpfolder" --app=http://localhost:4200 &
	;;
    75|Emwm_$Laptop)
	# 1. Limpiar procesos anteriores
	killall Xephyr 2>/dev/null

	# 2. Iniciar Xephyr en el display :9
	Xephyr :9 -br -ac -noreset -screen 1280x700 &

	# 3. Esperar a que inicialice
	sleep 1

	# 4. FORZAR a todo el script a usar el display de Xephyr
	export DISPLAY=:9

	# 5. Conectar por SSH ejecutando tu secuencia de arranque
	ssh \
	    -o ControlMaster=no \
	    -o ControlPath=none \
	    -S none -Y $(cat $HOME/.asdf)@$(cat $HOME/.fdsa) '
	    sleep 0.4 && setxkbmap latam &
	    sleep 0.5 && emacs -mm &
	    sleep 0.6 && xbindkeys &
	    sleep 0.7 && xdotool click 3 &
	    sleep 0.8 && xset r rate 150 110 &
	    sleep 0.9 && feh --bg-scale $HOME/monoliths-hm/white-background.png &
	    exec emwm
	    '
	;;
    76|Emacs_$Laptop)
	read -r SSH_USER < "$HOME/.asdf"
	read -r SSH_HOST < "$HOME/.fdsa"

	ssh \
	    -o ControlMaster=no \
	    -o ControlPath=none \
	    -Y \
	    "$SSH_USER@$SSH_HOST" \
	    emacs
	;;    
    77|Relax_Energy)
	echo deep | doas tee /sys/power/mem_sleep
	echo XHCI | doas tee /proc/acpi/wakeup
	echo TXHC | doas tee /proc/acpi/wakeup
	echo 1 | doas tee /sys/devices/system/cpu/intel_pstate/no_turbo
	echo 1200000 | doas tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
	;;
    78|Tmux_$Laptop)
	read -r SSH_USER < "$HOME/.asdf"
	read -r SSH_HOST < "$HOME/.fdsa"
	st -t "Tmux_${Laptop}" -e sh -c "ssh -tt ${SSH_USER}@${SSH_HOST} 'export TERM=xterm-256color; tmux attach || tmux'"
	;;
    79|Tmux_USA)
	dash "$HOME/$(cat $HOME/.personal)/USA.sh"
  	;;
    80|Luz_Off_Pantalla)
	( sleep 3 && xset dpms force off ) &
	;;
    81|Max_Energy)
	doas ./monoliths-llm/gaming-mode.sh
	;;
    82|Ver_Log)
	bash $HOME/monoliths-llm/ver-horas.sh &
	;;
    83|Google_Chrome_No_Inhibit)
	systemd-inhibit --why="Necesito mantener la conexión en TTY" google-chrome
	;;
    84|Firefox_Tmp)
	mkdir -p $HOME/.firefox-new-profile-$(date +%s) && firefox --profile $HOME/.firefox-new-profile-$(date +%s) &
	# folder="$HOME/.firefox-new-profile-$(date +%s)"; mkdir -p "$HOME/.$folder" && google-chrome-stable --user-data-dir="$HOME/.$folder"
	;;
    *)
	echo 'Opción no mapeada.'
	exit 1
	;;
esac
