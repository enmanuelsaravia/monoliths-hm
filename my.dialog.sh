#!/bin/dash

# export LANG=es_ES.UTF-8
# export LC_ALL=es_ES.UTF-8
# export LC_CTYPE=UTF-8

OPCION=$(dialog --clear --title "Lista de opciones" --cancel-label "Salir" \
        --menu "Selecciona una opcion y presiona Enter:" 22 80 15 \
        "Configurar_Resolucion" "Configurar pantalla a 1024x576 a 60Hz" \
        "Atajos_Teclado" "Iniciar demonio de atajos personalizados (xbindkeys)" \
        "Sincronizar_Hora" "Ajustar reloj del sistema mediante red (ntpd)" \
        "Reloj_Pantalla" "Mostrar un reloj permanente en la esquina" \
        "Esperar_Monitores" "Pausar 5 seg si se conectaron monitores externos" \
        "Arranque_Thinkpad" "Ejecutar inicio automatico para Thinkpad (BT/Scripts)" \
        "Auto_Teclado" "Forzar Latam continuamente y apagar BloqMayus" \
        "Estudio_Nativo" "Iniciar programa de literatura en idioma original" \
        "Estudio_Traducido" "Iniciar programa de literatura traducido al español" \
        "Pronunciacion" "Practicar lectura linea por linea con voz en Emacs (TTS)" \
        "Ver_Ultima_Grabacion" "Reproducir automaticamente tu ultimo video grabado (MPV)" \
        "Silenciar_Pitos" "Quitar sonido molesto de 'beep' del sistema (pcspkr)" \
        "Monitor_Bateria" "Seguimiento del nivel y tiempo de bateria en OSD" \
        "Ocultar_Barra_Bat" "Cerrar la barra inferior verde/roja de bateria" \
        "Mostrar_Barra_Bat" "Volver a iniciar la barra de nivel de bateria en pantalla" \
        "Resolucion_Consola" "Reiniciar PC para arreglar el tamaño de letras en terminal (TTY)" \
        "Audio_Por_HDMI" "Enrutar sonido al televisor (HDMI) y abrir Firefox" \
        "Control_Volumen" "Abrir mezclador de sonido en terminal (Alsamixer)" \
        "Alternar_Aviso" "Ocultar/Mostrar el aviso OSD de la hora permanentemente" \
        "Bloquear_Apagado" "Evitar que la pantalla se vuelva negra tras inactividad" \
        "Abrir_YouTube" "Lanzar pagina de YouTube usando el navegador integrado" \
        "Desactivar_BloqMayus" "Inhabilitar la tecla de Mayusculas para comodidad al escribir" \
        "Activar_BloqMayus" "Restaurar funcionamiento normal de tecla Mayusculas" \
        "Velocidad_Experto" "Hacer que la repeticion de teclas al presionar sea rapidisima" \
        "Velocidad_Novato" "Repetir mas lento cada letra en pulsacion sostenida" \
        "Layout_Latino_America" "Cambiar mapeo del teclado a disposicion usual de America Latina" \
        "Layout_Aleman" "Cambiar el layout del teclado a distribucion de Alemania (QWERTZ)" \
        "Layout_Espana" "Cambiar del reclado a disposicion clasica de España" \
        "Layout_Americano" "Cambiar mapeo a distribucion de Ingles USA" \
        "Modo_Noche_Monitor" "Reducir todo el brillo a 0.2 para evitar fatiga visual" \
        "Modo_Dia_Monitor" "Subir iluminacion a 0.4 para habitaciones muy claras" \
        "Calibrar_Trackball" "Acelerar un poco mas la bola del TrackBall Mouse" \
        "Prender_Bluetooth" "Iniciar administradores y activar conectividad Bluetooth" \
        "Apagar_Bluetooth" "Detener administrador dbus y apagar consumo Bluetooth" \
        "Apagar_Luz_Wifi" "Apagar el led molesto del dispositivo tplink usb" \
        "Servicio_VPN" "Comenzar conectividad virtual privada desde un buffer de emacs" \
        "Lanzar_Emacs_Normal" "Iniciar instancia principal y completa del editor de texto Emacs" \
        "Lanzar_Emacs_Desarrollo" "Carga rapida de Emacs vacio con fondo negro visualmente" \
        "Asistente_ChatGPT" "Abrir aplicacion web oficial de chat bot inteligente en Chromium" \
        "Configurar_Pantallas" "Lanzar 'Arandr' para ajustar visualmente los monitores conectados" \
        "Camara_Espejo" "Proyectar webcam frontal en esquina inferiar e imagen invertida" \
        "Grabar_Video_1m" "Hacer un clip grabando mi escritorio solo durante un minuto continuo" \
        "Grabar_Video_2m" "Capturar de pantalla grabando por dos minutos seguido" \
        "Grabar_Video_6m" "Para grabar segmentos medios equivalentes a 6 minutos" \
        "Grabar_Video_20m" "Capturas grandes sin interrupcion en un periodo de viente min." \
        "Grabar_Video_30m" "Extremo para capturar clase por el periodo de media hora" \
        "Reiniciar_Sistema" "Hacer un apagado controlado y encender inmediatamente el computador" \
        "Apagar_Equipo" "Cerrar demonios y apagar el equipo por hardware permanentemente" \
        "Cerrar_Mi_Sesion" "Matar aplicaciones abiertas y botar del servidor X a login manager" \
        "Respaldar_Archivos" "Enviar modificacion locales a backup usando codigo git propio" \
        "Visitar_Mi_Guia" "Visualizar atajos FVWM base leyendo el html en navegador" \
        "Reloj_Segundos" "Lanzar barra de progreso visual pidiendo cuenta en segundos primero" \
        "Reloj_Minutos" "Barra especifica pidiendo cuenta grande en formato de minutos directos" \
        "Rutina_Tracking_A" "Trakear productivo mediante (xtimemon) de [10-13, 14-19]" \
        "Rutina_Tracking_B" "Trakear productivo mediante (xtimemon) de [10-12, 14-20]" \
        "Rutina_Tracking_C" "Trakear productivo mediante (xtimemon) de [09-13, 14-18]" \
        "Rutina_Tracking_D" "Trakear productivo mediante (xtimemon) de [09-12, 14-19]" \
        "Rutina_Tracking_E" "Trakear productivo mediante (xtimemon) de [09-12, 15-20]" \
        "Rutina_Tracking_F" "Trakear extrema mañana usando xtimemon desde [07-09]" \
        3>&1 1>&2 2>&3)

    exit_status=$?
    if [ $exit_status -ne 0 ]; then
        clear
        exit 0
    fi

    case "$OPCION" in
        Configurar_Resolucion)
            MODELINE_NAME=$(cvt 1024 576 60 | awk '/Modeline/ {print $2}')
            MODELINE_PARAMS=$(cvt 1024 576 60 | awk '/Modeline/ {for(i=3;i<=NF;i++) printf $i " "; print ""}')
            xrandr --newmode $MODELINE_NAME $MODELINE_PARAMS
            xrandr --addmode eDP-1 $MODELINE_NAME
            xrandr --output eDP-1 --mode $MODELINE_NAME
            ;;
        Atajos_Teclado)
            xbindkeys
            ;;
        Sincronizar_Hora)
            doas ntpd
            ;;
        Reloj_Pantalla)
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
        Esperar_Monitores)
            if xrandr | grep -q ' DP-1 connected' ||
                    xrandr | grep -q 'DP-2 connected' ||
                    xrandr | grep -q 'HDMI-1 connected'; then
                sleep 5s
            fi
            ;;
        Arranque_Thinkpad)
            if doas dmesg | grep thinkpad > /dev/null; then
                sleep 2 && cd && bash literatura.sh && dash $HOME/monoliths-hm/autoinit.sh
                doas service dbus start; doas service bluetooth start
                ( sleep 3 && echo -e "power on\nexit" | bluetoothctl )
            fi
            ;;
        Auto_Teclado)
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
        Resolucion_Consola)
            ( [ -f /etc/default/grub.normal ] || doas cp /etc/default/grub /etc/default/grub.normal ) && \
                cat /etc/default/grub | grep -q '800x600' && \
                ( doas cp /etc/default/grub.normal /etc/default/grub ) || \
                    ( echo 'GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"' | doas tee -a /etc/default/grub && \
                          echo 'GRUB_GFXMODE=800x600' | doas tee -a /etc/default/grub && \
                          echo 'GRUB_GFXPAYLOAD_LINUX=keep' | doas tee -a /etc/default/grub ) && \
                        ( doas grub-mkconfig -o /boot/grub/grub.cfg && doas reboot )
            ;;
        Calibrar_Trackball)
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
        Monitor_Bateria)
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
        Alternar_Aviso)
            [ -f "$HOME/.stop_personal_osdx" ] && rm "$HOME/.stop_personal_osdx" || touch "$HOME/.stop_personal_osdx"
            ;;
        Control_Volumen)
            export DISPLAY=:0
            xterm -e 'alsamixer'
            ;;
        Silenciar_Pitos)
            doas rmmod pcspkr
            ;;
        Rutina_Tracking_A)
            HOUR=$(date +%H); if [ $HOUR -ge 10 -a $HOUR -lt 13 ]; then ( xtimemon -S 10:00 -E 13:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 19 ]; then ( xtimemon -S 14:00 -E 19:00 -p top ); fi
            ;;
        Rutina_Tracking_B)
            HOUR=$(date +%H); if [ $HOUR -ge 10 -a $HOUR -lt 12 ]; then ( xtimemon -S 10:00 -E 12:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 20 ]; then ( xtimemon -S 14:00 -E 20:00 -p top ); fi
            ;;
        Rutina_Tracking_C)
            HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 13 ]; then ( xtimemon -S 09:00 -E 13:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 18 ]; then ( xtimemon -S 14:00 -E 18:00 -p top ); fi
            ;;
        Rutina_Tracking_D)
            HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 12 ]; then ( xtimemon -S 09:00 -E 12:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 19 ]; then ( xtimemon -S 14:00 -E 19:00 -p top ); fi
            ;;
        Rutina_Tracking_E)
            HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 12 ]; then ( xtimemon -S 09:00 -E 12:00 -p top ); elif [ $HOUR -ge 15 -a $HOUR -lt 20 ]; then ( xtimemon -S 15:00 -E 20:00 -p top ); fi
            ;;
        Modo_Noche_Monitor)
            for a in $(xrandr | grep ' connected' | awk '{print $1}'); do xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.2; done
            ;;
        Modo_Dia_Monitor)
            for a in $(xrandr | grep ' connected' | awk '{print $1}'); do xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.4; done
            ;;
        Audio_Por_HDMI)
            doas service tor start && doas service sndiod start && sleep 1 && sndiod -f rsnd/0,3 && firefox > /dev/null 2>&1
            ;;
        Prender_Bluetooth)
            doas service dbus start; doas service bluetooth start
            ;;
        Apagar_Bluetooth)
            doas service dbus stop; doas service bluetooth stop
            ;;
        Camara_Espejo)
            ffplay -fflags nobuffer -flags low_delay -framedrop -vf 'crop=250:530:(iw-250)/2:(ih-530)/2,hflip' /dev/video0
            ;;
        Rutina_Tracking_F)
            HOUR=$(date +%H); if [ $HOUR -ge 7 -a $HOUR -lt 10 ]; then ( xtimemon -S 7:20 -E 9:20 -p top ); fi
            ;;
        Apagar_Luz_Wifi)
            ( echo 0 | doas tee /sys/class/leds/ath9k_htc-phy1/brightness || echo 0 | doas tee /sys/class/leds/ath9k_htc-phy0/brightness )
            ;;
        Bloquear_Apagado)
            xset s off && xset s noblank && xset -dpms
            ;;
        Estudio_Nativo)
            cd $HOME/literatura && dash literatura.sh
            ;;
        Estudio_Traducido)
            cd $HOME/literatura-to-es && dash literatura.sh
            ;;
        Desactivar_BloqMayus)
            setxkbmap -option caps:none
            ;;
        Visitar_Mi_Guia)
            bash /usr/share/fvwm3/default-config/c || chromium
            ;;
        Servicio_VPN)
            emacs --eval='(ofv)'
            ;;
        Velocidad_Experto)
            while true; do
                xset r rate 150 110
                sleep 1
            done
            ;;
        Ocultar_Barra_Bat)
            killall xbattmon
            ;;
        Activar_BloqMayus)
            setxkbmap -option
            ;;
        Velocidad_Novato)
            while true; do
                xset r rate 140 60
                sleep 1
            done
            ;;
        Mostrar_Barra_Bat)
            xbattmon
            ;;
        Cerrar_Mi_Sesion)
            doas killall X
            ;;
        Apagar_Equipo)
            doas poweroff
            ;;
        Configurar_Pantallas)
            arandr
            ;;
        Reiniciar_Sistema)
            doas reboot
            ;;
        Layout_Latino_America)
            echo 'latam' > /tmp/layout.my
            while true; do
                LAYOUT=$(cat /tmp/layout.my)
                setxkbmap "$LAYOUT"
                sleep 1
            done
            ;;
        Lanzar_Emacs_Normal)
            emacs -mm
            ;;
        Pronunciacion)
            emacs -mm -q -Q --file=$HOME/monoliths-llm/text_english_training.el --eval='(eval-buffer)'
            if ! doas dmesg | grep thinkpad > /dev/null; then
                audacity
            fi
            ;;
        Layout_Aleman)
            echo 'de' > /tmp/layout.my
            while true; do
                LAYOUT=$(cat /tmp/layout.my)
                setxkbmap "$LAYOUT"
                sleep 1
            done
            ;;
        Layout_Americano)
            echo 'us' > /tmp/layout.my
            while true; do
                LAYOUT=$(cat /tmp/layout.my)
                setxkbmap "$LAYOUT"
                sleep 1
            done
            ;;
        Layout_Espana)
            echo 'es' > /tmp/layout.my
            while true; do
                LAYOUT=$(cat /tmp/layout.my)
                setxkbmap "$LAYOUT"
                sleep 1
            done
            ;;
        Lanzar_Emacs_Desarrollo)
            emacs -mm -fg white -bg black -q -Q
            ;;
        Asistente_ChatGPT)
            chromium --app='https://chatgpt.com'
            ;;
        Respaldar_Archivos)
            cd && dash saravia
            ;;
        Abrir_YouTube)
            chromium --app='https://youtube.com'
            ;;
        Grabar_Video_1m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 1
            end=$((SECONDS + 1*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
        Grabar_Video_2m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 2
            end=$((SECONDS + 2*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
        Grabar_Video_6m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 6
            end=$((SECONDS + 6*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
        Grabar_Video_20m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 20
            end=$((SECONDS + 20*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
        Grabar_Video_30m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 30
            end=$((SECONDS + 30*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
        Ver_Ultima_Grabacion)
            latest_video=$(ls -t "$HOME"/simplescreenrecorder-*.mkv 2>/dev/null | head -1)
            mpv "$latest_video"
            ;;
        Reloj_Segundos)
            dash $HOME/monoliths-llm/simple_second_counter_xterm-N-yad.sh
            ;;
        Reloj_Minutos)
            dash $HOME/monoliths-llm/special_minute_counter_xtimemon-N-yad.sh
            ;;
    esac
