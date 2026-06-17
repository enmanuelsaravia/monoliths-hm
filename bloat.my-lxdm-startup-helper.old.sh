#!/bin/dash

# export LANG=es_ES.UTF-8
# export LC_ALL=es_ES.UTF-8
# export LC_CTYPE=UTF-8

MODELINE_NAME=$(cvt 1024 576 60 | awk '/Modeline/ {print $2}')
MODELINE_PARAMS=$(cvt 1024 576 60 | awk '/Modeline/ {for(i=3;i<=NF;i++) printf $i ' '; print ''}')

xrandr --newmode $MODELINE_NAME $MODELINE_PARAMS
xrandr --addmode eDP-1 $MODELINE_NAME
xrandr --output eDP-1 --mode $MODELINE_NAME # $(doas dmesg | grep thinkpad > /dev/null && echo '--rotate inverted' || '')

xbindkeys &

doas ntpd &

if [ ! -f /tmp/clock_is_run_already.pid ]; then
    while true; do
	if [ ! -f $HOME/.stop_personal_osdx ]; then
	    touch /tmp/clock_is_run_already.pid
	    dash $HOME/monoliths-hm/optime.personal_osdx.sh
	fi
	sleep 0.1
    done &
fi

if xrandr | grep -q ' DP-1 connected' ||
	xrandr | grep -q 'DP-2 connected' ||
	xrandr | grep -q 'HDMI-1 connected'; then
    sleep 5s
fi

if doas dmesg | grep thinkpad > /dev/null; then
    sleep 2 && cd && bash literatura.sh && dash $HOME/monoliths-hm/autoinit.sh &
    doas service dbus start; doas service bluetooth start
    ( sleep 3 && echo -e "power on\nexit" | bluetoothctl ) &
fi

echo 'latam' > /tmp/layout.my
echo 'caps:none' > /tmp/caps_mode.my
while true; do
    CAPS_MODE=$(cat /tmp/caps_mode.my)
    LAYOUT=$(cat /tmp/layout.my)
    setxkbmap "$LAYOUT"
    setxkbmap -option "$CAPS_MODE"
    sleep 1
done &

# Definir cuál ejecutable usar
if [ -f $HOME/PyYad/dist/PyYad ]; then
    YAD="$HOME/PyYad/dist/PyYad"
else
    YAD='yad'
fi

sleep 5s

while true; do
    # Evita tildes y usa UTF-8 seguro si es necesario
    OPCION=$($YAD --title='Lista de opciones, clic y usar flechas' \
		 --width=420 --height=650 \
		 --window-icon="$HOME/monoliths-hm/icon.png" \
		 --list --column='Icono:IMG' --column='Comando' --column='Descripcion' \
		 "$HOME/monoliths-hm/media-playlist-add.png" 'literatura' 'Estudiar sin esfuerzo sin traduccion' \
		 "$HOME/monoliths-hm/media-playlist-add.png" 'literatura_to_es' 'Estudiar sin esfuerzo traducido al spanish' \
		 "$HOME/monoliths-hm/media-playlist-add.png" 'read_line_by_line' 'To pronounce a language words' \
		 "$HOME/monoliths-hm/appointment-soon.png" 'watch_last' 'Ver el ultimo video' \
		 "$HOME/monoliths-hm/audio-volume-high.png" 'quitar_beep' 'Quitar sonido BEEP' \
		 "$HOME/monoliths-hm/battery.png" 'track_battery_time' 'Hace un $HOME/.start_at.log y un track here ~/.track_at.log' \
		 "$HOME/monoliths-hm/battery.png" 'ocultar_xbattmon' 'Ocultar xbattmon' \
		 "$HOME/monoliths-hm/battery.png" 'mostrar_xbattmon' 'Mostrar xbattmon' \
		 "$HOME/monoliths-hm/system-reboot.png" 'switch_tty_nomodeset' 'Reboot without modeset for hack tty fontsize' \
		 "$HOME/monoliths-hm/audio-volume-high.png" 'audio_hdmi_firefox' 'Activar audio HDMI para Firefox' \
		 "$HOME/monoliths-hm/audio-volume-high.png" 'volume' 'Panel de volumen alsamixer' \
		 "$HOME/monoliths-hm/appointment-soon.png" 'hora_y_aviso' 'Mostrar/Ocultar Hora y type-to-move-cursor' \
		 "$HOME/monoliths-hm/view-on.png" 'siempre_encendido' 'Para no apagar pantalla' \
		 "$HOME/monoliths-hm/view-on.png" 'Normal_YouTube' 'YouTube normal en el navegador chromium' \
		 "$HOME/monoliths-hm/view-on.png" 'yt_local' 'Youtube sin tor' \
		 "$HOME/monoliths-hm/view-on.png" 'ver_yt_local_como_hacker' 'ver Yt-local como un rms-Hacker http://192.168.178.38' \
		 "$HOME/monoliths-hm/view-on.png" 'mirar_donde_esta_yt_local' 'Mostrar la IP disponible en la red LAN de Yt-local' \
		 "$HOME/monoliths-hm/input-keyboard.png" 'inhabilitar_caps' 'Inhabilitar Bloq Mayus funcionamiento con Bluetooth' \
		 "$HOME/monoliths-hm/input-keyboard.png" 'habilitar_caps' 'Habilitar Bloq Mayus modo normal' \
		 "$HOME/monoliths-hm/input-keyboard.png" 'teclas_rapidas' 'Teclas rapidas para expertos' \
		 "$HOME/monoliths-hm/input-keyboard.png" 'teclas_lentas' 'Teclas lentas para novatos' \
		 "$HOME/monoliths-hm/input-keyboard.png" 'latam' 'Teclas Latam' \
		 "$HOME/monoliths-hm/input-keyboard.png" 'de' 'Teclas Deutsch' \
		 "$HOME/monoliths-hm/input-keyboard.png" 'es' 'Teclas Spain' \
		 "$HOME/monoliths-hm/input-keyboard.png" 'us' 'Teclas US' \
		 "$HOME/monoliths-hm/media-playlist-add.png" 'luz_para_oscuro' 'Optimizar luz pantalla' \
		 "$HOME/monoliths-hm/media-playlist-add.png" 'luz_para_claro' 'Optimizar luz pantalla' \
		 "$HOME/monoliths-hm/input-mouse.png" 'trackball_config' 'Configurar trackball' \
		 "$HOME/monoliths-hm/cpu.png" 'cpu_bajo_consumo' 'CPU en bajo consumo' \
		 "$HOME/monoliths-hm/user-identity.png" 'user_auto' 'Ejecutar $HOME/.user_auto.sh' \
		 "$HOME/monoliths-hm/user-identity.png" 'execute_auto' 'Ejecutar $HOME/.auto.sh' \
		 "$HOME/monoliths-hm/user-identity.png" 'lumina_1+2' 'Ejecutar $HOME/.user-1+2-lumina.sh' \
		 "$HOME/monoliths-hm/user-identity.png" 'saravia' 'Ejecutar $HOME/.saravia.sh' \
		 "$HOME/monoliths-hm/network-bluetooth-connected.png" 'up_bluetooth' 'Encender bluetooth' \
		 "$HOME/monoliths-hm/network-bluetooth-off.png" 'down_bluetooth' 'Apagar bluetooth' \
		 "$HOME/monoliths-hm/network-wireless.png" 'luz_tplink' 'Apagar la luz tplink' \
		 "$HOME/monoliths-hm/applications-internet.png" 'conectar_vpn' 'Conectar a la vpn' \
		 "$HOME/monoliths-hm/emacs.png" 'emacs' 'Normal emacs' \
		 "$HOME/monoliths-hm/emacs_develop.png" 'emacs_develop' 'Develop emacs' \
		 "$HOME/monoliths-hm/face-smile.png" 'chatgpt' 'chatgpt rapido' \
		 "$HOME/monoliths-hm/system-file-manager.png" 'screen_manager' 'Arandr' \
		 "$HOME/monoliths-hm/system-file-manager.png" 'postular' 'Trabajo linkedin' \
		 "$HOME/monoliths-hm/system-file-manager.png" 'peliculas' '832x624' \
		 "$HOME/monoliths-hm/media-playlist-add.png" 'verme' 'Mpv para verme' \
	 	 "$HOME/monoliths-hm/media-playlist-add.png" 'rec_1_min' 'Simplescreenrecorder 1 minute' \
		 "$HOME/monoliths-hm/media-playlist-add.png" 'rec_2_min' 'Simplescreenrecorder 2 minute' \
		 "$HOME/monoliths-hm/media-playlist-add.png" 'rec_6_min' 'Simplescreenrecorder 6 minute' \
		 "$HOME/monoliths-hm/media-playlist-add.png" 'rec_20_min' 'Simplescreenrecorder 20 minute' \
		 "$HOME/monoliths-hm/media-playlist-add.png" 'rec_30_min' 'Simplescreenrecorder 30 minute' \
		 "$HOME/monoliths-hm/system-reboot.png" 'do_reboot' 'Reiniciar' \
		 "$HOME/monoliths-hm/system-shutdown.png" 'do_poweroff' 'Apagar' \
		 "$HOME/monoliths-hm/application-exit.png" 'do_logout' 'Log out' \
		 "$HOME/monoliths-hm/system-reboot.png" 'sync_git' 'Sincronizar git' \
		 "$HOME/monoliths-hm/c.png" 'c' '/usr/share/fvwm3/default-config/c.htm' \
		 "$HOME/monoliths-hm/media-playlist-add.png" 'counter_seconds' 'Pregunta por cantidad de segundos para mostrar una barra de progreso' \
		 "$HOME/monoliths-hm/media-playlist-add.png" 'counter_minutes' 'Pregunta por cantidad de minutos para mostrar una barra de progreso especial' \
		 --button='Ejecutar ...o tipea Enter:0' \
		 --separator=':')

    # Extraer la primera columna (el comando)
    COMANDO=$(echo "$OPCION" | cut -d: -f2)

    # Ejecutar segun la opcion
    case "$COMANDO" in
	switch_tty_nomodeset)
            ( [ -f /etc/default/grub.normal ] || doas cp /etc/default/grub /etc/default/grub.normal ) && \
		cat /etc/default/grub | grep -q '800x600' && \
		( doas cp /etc/default/grub.normal /etc/default/grub ) || \
		    ( echo 'GRUB_CMDLINE_LINUX_DEFAULT='nomodeset'' | doas tee -a /etc/default/grub && \
			  echo 'GRUB_GFXMODE=800x600' | doas tee -a /etc/default/grub && \
			  echo 'GRUB_GFXPAYLOAD_LINUX=keep' | doas tee -a /etc/default/grub ) && \
			( doas grub-mkconfig -o /boot/grub/grub.cfg && doas reboot )
            ;;
	trackball_config)
	    while true; do
		ID=$(xinput list | grep 'SONiX Perixx Trackball Keyboard Mouse' | grep -o 'id=[0-9]*' | cut -d= -f2)
		PROPS=$(xinput list-props "$ID")
		echo "$PROPS" | grep -q 'libinput Accel Speed' && \
		    ( xinput --set-prop "$ID" 'libinput Accel Speed' -1.0; xinput --set-prop "$ID" 'libinput Accel Profile Enabled' 1 0 ) || \
			( xinput --set-prop "$ID" 'Device Accel Constant Deceleration' --type=float 4.0; \
			  xinput --set-prop "$ID" 'Device Accel Adaptive Deceleration' --type=float 4.0; \
			  xinput --set-prop "$ID" 'Device Accel Velocity Scaling' --type=float 4.0 )
		sleep 1
	    done &
            ;;
	track_battery_time)
            if [ ! -f /tmp/clock_is_run_already.pid ]; then
		doas ntpd
		echo "$(date)" > $HOME/.start_at.log
		(
                    while true; do
			touch /tmp/clock_is_run_already.pid
			echo "$(date)" > $HOME/.track_at.log
			printf "B.T. \n\n%s\n%s" "$(date +'%T')" "$(wmctrl -l | grep -q 'ctrl+shift releases' && echo 'Xephyr quit Ctrl+Shift' || ( grep -q 'NOT MOUSE' $HOME/.xbindkeysrc && echo 'Keyboard quit Alt+2' || echo 'Mouse quit Alt+1' ))" | osd_cat --pos=top --align=right --offset=50 --color=green --shadow=1 --delay=1 --lines=4 --font='-misc-fixed-*-*-*-*-30-*-*-*-*-*-*-*'
			sleep 0.5
                    done &
		)
            fi
            ;;
	hora_y_aviso)
            [ -f "$HOME/.stop_personal_osdx" ] && rm "$HOME/.stop_personal_osdx" || touch "$HOME/.stop_personal_osdx"
            ;;
	volume)
	    xterm -e 'alsamixer'
	    ;;
	quitar_beep)
	    doas rmmod pcspkr
	    ;;
	xtime_10to13_14to19)
            HOUR=$(date +%H); if [ $HOUR -ge 10 -a $HOUR -lt 13 ]; then ( xtimemon -S 10:00 -E 13:00 -p top & ); elif [ $HOUR -ge 14 -a $HOUR -lt 19 ]; then ( xtimemon -S 14:00 -E 19:00 -p top & ); fi
            ;;
	xtime_10to12_14to20)
            HOUR=$(date +%H); if [ $HOUR -ge 10 -a $HOUR -lt 12 ]; then ( xtimemon -S 10:00 -E 12:00 -p top & ); elif [ $HOUR -ge 14 -a $HOUR -lt 20 ]; then ( xtimemon -S 14:00 -E 20:00 -p top & ); fi
            ;;
	xtime_9to13_14to18)
            HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 13 ]; then ( xtimemon -S 09:00 -E 13:00 -p top & ); elif [ $HOUR -ge 14 -a $HOUR -lt 18 ]; then ( xtimemon -S 14:00 -E 18:00 -p top & ); fi
            ;;
	xtime_9to12_14to19)
            HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 12 ]; then ( xtimemon -S 09:00 -E 12:00 -p top & ); elif [ $HOUR -ge 14 -a $HOUR -lt 19 ]; then ( xtimemon -S 14:00 -E 19:00 -p top & ); fi
            ;;
	xtime_9to12_15to20)
            HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 12 ]; then ( xtimemon -S 09:00 -E 12:00 -p top & ); elif [ $HOUR -ge 15 -a $HOUR -lt 20 ]; then ( xtimemon -S 15:00 -E 20:00 -p top & ); fi
            ;;
	luz_para_oscuro)
            for a in $(xrandr | grep ' connected' | awk '{print $1}'); do xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.2; done
            ;;
	luz_para_claro)
            for a in $(xrandr | grep ' connected' | awk '{print $1}'); do xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.4; done
            ;;
	audio_hdmi_firefox)
            doas service tor start && doas service sndiod start && sleep 1 && sndiod -f rsnd/0,3 && firefox > /dev/null 2>&1 &
            ;;
	up_bluetooth)
            doas service dbus start; doas service bluetooth start
            ;;
	down_bluetooth)
            doas service dbus stop; doas service bluetooth stop
            ;;
	verme)
            ffplay -fflags nobuffer -flags low_delay -framedrop -vf 'crop=250:530:(iw-250)/2:(ih-530)/2,hflip' /dev/video0 &
            ;;
	xtime_7to9)
            HOUR=$(date +%H); if [ $HOUR -ge 7 -a $HOUR -lt 10 ]; then ( xtimemon -S 7:20 -E 9:20 -p top & ); fi
            ;;
	luz_tplink)
            ( echo 0 | doas tee /sys/class/leds/ath9k_htc-phy1/brightness || echo 0 | doas tee /sys/class/leds/ath9k_htc-phy0/brightness )
            ;;
	cascada_xephyr)
            xterm -e 'bash $HOME/.cascada.sh' &
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
	lumina_1+2)
            bash $HOME/.user-1+2-lumina.sh &
            ;;
	cpu_bajo_consumo)
            bash $HOME/battery-saver.sh
            ;;
	inhabilitar_caps)
	    setxkbmap -option caps:none
	    # revert with $ setxkbmap -option
            ;;
	saravia)
            bash $HOME/.saravia.sh &
            ;;
	c)
            bash /usr/share/fvwm3/default-config/c || chromium &
            ;;
	conectar_vpn)
            emacs --eval='(ofv)' &
            ;;
	peliculas)
            bash $HOME/.pelicula.sh &
            ;;
	execute_auto)
            bash $HOME/.auto.sh &
            ;;
	user_auto)
            bash $HOME/.user_auto.sh &
            ;;
	teclas_rapidas)
	    while true; do
		xset r rate 150 110
		sleep 1
	    done &
            ;;
	postular)
            bash $HOME/.trabajo.sh &
            ;;
	ocultar_xbattmon)
            killall xbattmon
            ;;
	habilitar_caps)
            setxkbmap -option
            ;;
	teclas_lentas)
	    while true; do
		xset r rate 140 60
		sleep 1
	    done &
            ;;
	mostrar_xbattmon)
            xbattmon &
            ;;
	do_logout)
            doas killall X &
            ;;
	yt_local)
            bash $HOME/yt-local/yt.sh &
            ;;
	ver_yt_local_como_hacker)
	    doas service sndiod start || doas service sndiod restart &
	    (xterm -e alsamixer) &
            (badwolf 'http://192.168.178.38') &
	    (sleep 1 && wmctrl -r 'YT Local' -b add,fullscreen) &
            ;;
	mirar_donde_esta_yt_local)
	    dash $HOME/.yt-local/print_yout_ip_for_share.sh "yt-local → http://$(ip route get 1.1.1.1 | awk '{print $7}')" &
	    ;;
	do_poweroff)
            doas poweroff
            ;;
	screen_manager)
            arandr &
            ;;
	do_reboot)
            doas reboot
            ;;
	latam)
	    echo 'latam' > /tmp/layout.my
	    while true; do
		LAYOUT=$(cat /tmp/layout.my)
		setxkbmap "$LAYOUT"
		sleep 1
	    done &
            ;;
	emacs)
            emacs -mm &
            ;;
	read_line_by_line)
	    # emacs -mm -fg white -bg black -q -Q --file=$HOME/monoliths-llm/text_english_training.el --eval='(eval-buffer)' &
	    emacs -mm -q -Q --file=$HOME/monoliths-llm/text_english_training.el --eval='(eval-buffer)' &
	    if ! doas dmesg | grep thinkpad > /dev/null; then
		audacity &
	    fi
	    ;;
	de)
	    echo 'de' > /tmp/layout.my
	    while true; do
		LAYOUT=$(cat /tmp/layout.my)
		setxkbmap "$LAYOUT"
		sleep 1
	    done &
            ;;
	us)
	    echo 'us' > /tmp/layout.my
	    while true; do
		LAYOUT=$(cat /tmp/layout.my)
		setxkbmap "$LAYOUT"
		sleep 1
	    done &
            ;;
	es)
	    echo 'es' > /tmp/layout.my
	    while true; do
		LAYOUT=$(cat /tmp/layout.my)
		setxkbmap "$LAYOUT"
		sleep 1
	    done &
            ;;
	emacs_develop)
	    emacs -mm -fg white -bg black -q -Q &
	    ;;
	chatgpt)
	    chromium --app='https://chatgpt.com' &
	    ;;
	sync_git)
	    cd && dash saravia &
	    ;;
	Normal_YouTube)
	    chromium --app='https://youtube.com' &
	    ;;
	rec_1_min)
	    dash $HOME/monoliths-llm/rec-to-certain-min.sh 1 &
	    end=$((SECONDS + 1*60))

	    while [ $SECONDS -lt $end ]; do
		[ -e /tmp/.stop ] && break
		sleep 1
	    done
	    sleep 10
	    ;;
	rec_2_min)
	    dash $HOME/monoliths-llm/rec-to-certain-min.sh 2 &
	    end=$((SECONDS + 2*60))

	    while [ $SECONDS -lt $end ]; do
		[ -e /tmp/.stop ] && break
		sleep 1
	    done
	    sleep 10
	    ;;
	rec_6_min)
	    dash $HOME/monoliths-llm/rec-to-certain-min.sh 6 &
	    end=$((SECONDS + 6*60))

	    while [ $SECONDS -lt $end ]; do
		[ -e /tmp/.stop ] && break
		sleep 1
	    done
	    sleep 10
	    ;;
	rec_20_min)
	    dash $HOME/monoliths-llm/rec-to-certain-min.sh 20 &
	    end=$((SECONDS + 20*60))

	    while [ $SECONDS -lt $end ]; do
		[ -e /tmp/.stop ] && break
		sleep 1
	    done
	    sleep 10
	    ;;
	rec_30_min)
	    dash $HOME/monoliths-llm/rec-to-certain-min.sh 30 &
	    end=$((SECONDS + 30*60))

	    while [ $SECONDS -lt $end ]; do
		[ -e /tmp/.stop ] && break
		sleep 1
	    done
	    sleep 10
	    ;;
	watch_last)
	    latest_video=$(ls -t "$HOME"/simplescreenrecorder-*.mkv 2>/dev/null | head -1)
	    mpv $latest_video
	    ;;
	counter_seconds)
	    bash $HOME/monoliths-llm/simple_second_counter_xterm-N-yad.sh
	    ;;
	counter_minutes)
	    bash $HOME/monoliths-llm/special_minute_counter_xtimemon-N-yad.sh &
	    ;;
    esac

done
