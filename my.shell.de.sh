#!/bin/dash

echo "=== Optionsliste ==="
echo ""
echo "1) Aufloesung_Einstellen - Bildschirm auf 1024x576 bei 60Hz konfigurieren"
echo "2) Tastaturkürzel - Benutzerdefinierte Tastenkombinationen starten (xbindkeys)"
echo "3) Zeit_Synchronisieren - Systemuhr über Netzwerk anpassen (ntpd)"
echo "4) Bildschirmuhr - Einfache permanente Uhr in der Ecke anzeigen"
echo "5) Monitore_Warten - 5 Sekunden pausieren, wenn externe Monitore verbunden sind"
echo "6) Thinkpad_Start - Automatischen Start für Thinkpad ausführen (BT/Scripts)"
echo "7) Auto_Tastatur - Latam-Layout kontinuierlich erzwingen und CapsLock umschalten"
echo "8) Konsolenaufloesung - PC neu starten, um die Schriftgröße im Terminal zu reparieren (TTY)"
echo "9) Trackball_Kalibrieren - TrackBall-Maus etwas mehr beschleunigen"
echo "10) Batteriemonitor - Batteriestand und -zeit im OSD verfolgen"
echo "11) Hinweis_Umschalten - Permanente OSD-Zeitanzeige ausblenden/anzeigen"
echo "12) Lautstaerkeregler - Soundmixer im Terminal öffnen (Alsamixer)"
echo "13) Pieptoene_Stumm - Lästige System-Pieptöne abschalten (pcspkr)"
echo "14) Tracking_Routine_A - Produktivität via xtimemon tracken von [10-13, 14-19]"
echo "15) Tracking_Routine_B - Produktivität via xtimemon tracken von [10-12, 14-20]"
echo "16) Tracking_Routine_C - Produktivität via xtimemon tracken von [09-13, 14-18]"
echo "17) Tracking_Routine_D - Produktivität via xtimemon tracken von [09-12, 14-19]"
echo "18) Tracking_Routine_E - Produktivität via xtimemon tracken von [09-12, 15-20]"
echo "19) Nachtmodus_Monitor - Helligkeit auf 0.2 reduzieren, um visuelle Ermüdung zu vermeiden"
echo "20) Tagmodus_Monitor - Beleuchtung auf 0.4 für sehr helle Räume erhöhen"
echo "21) Audio_Ueber_HDMI - Ton zum Fernseher (HDMI) leiten und Firefox öffnen"
echo "22) Bluetooth_Einschalten - Manager starten und Bluetooth-Konnektivität aktivieren"
echo "23) Bluetooth_Ausschalten - DBus-Manager stoppen und Bluetooth-Verbrauch deaktivieren"
echo "24) Spiegelkamera - Front-Webcam ins untere Eck projizieren, invertiertes Bild"
echo "25) Tracking_Routine_F - Extremes Morgen-Tracking via xtimemon von [07-09]"
echo "26) WLAN_Licht_Aus - Störende LED des TP-Link USB-Geräts ausschalten"
echo "27) Bildschirm_Ausschalten_Sperren - Verhindern, dass der Bildschirm nach Inaktivität schwarz wird"
echo "28) Natives_Lernen - Literaturprogramm in Originalsprache starten"
echo "29) Uebersetztes_Lernen - Literaturprogramm auf Spanisch übersetzt starten"
echo "30) CapsLock_Deaktivieren - Feststelltaste für bequemeres Tippen deaktivieren"
echo "31) Meine_Anleitung_Besuchen - Basis-FVWM-Verknüpfungen (HTML) im Browser ansehen"
echo "32) VPN_Dienst - Virtuelle private Netzwerkverbindung aus dem Emacs-Buffer starten"
echo "33) Experten_Geschwindigkeit - Tastenwiederholung extrem schnell machen"
echo "34) Akku_Leiste_Ausblenden - Untere grüne/rote Akkuleiste schließen"
echo "35) CapsLock_Aktivieren - Normale Feststelltastenfunktion wiederherstellen"
echo "36) Anfaenger_Geschwindigkeit - Jeden Buchstaben bei anhaltendem Druck langsamer wiederholen"
echo "37) Akku_Leiste_Anzeigen - Akku-Niveauanzeige auf dem Bildschirm neu starten"
echo "38) Abmelden - Geöffnete Apps beenden und vom X-Server zum Login-Manager"
echo "39) Ausschalten - Daemonen schließen und Hardware permanent ausschalten"
echo "40) Bildschirme_Konfigurieren - 'Arandr' starten, um angeschlossene Monitore visuell anzupassen"
echo "41) System_Neustarten - Kontrolliertes Herunterfahren durchführen und Computer sofort einschalten"
echo "42) Lateinamerika_Layout - Tastatur auf typisch lateinamerikanisches Layout ändern"
echo "43) Emacs_Normal_Starten - Haupt-Emacs-Texteditor in voller Instanz starten"
echo "44) Aussprache - Mündliches Lesen Zeile für Zeile in Emacs üben (TTS)"
echo "45) Deutsches_Layout - Tastaturlayout auf deutsche Verteilung ändern (QWERTZ)"
echo "46) Amerikanisches_Layout - Zuweisung auf USA-Englisch-Verteilung ändern"
echo "47) Spanien_Layout - Tastatur auf klassisches Spanien-Layout ändern"
echo "48) Emacs_Dev_Starten - Schnelles Laden eines leeren Emacs mit optisch schwarzem Hintergrund"
echo "49) ChatGPT_Assistent - Offizielle intelligente Chatbot-Web-App in Chromium öffnen"
echo "50) Dateien_Sichern - Lokale Änderungen mit benutzerdefiniertem Git-Code zum Backup senden"
echo "51) YouTube_Oeffnen - YouTube-Seite im integrierten Browser starten"
echo "52) Video_Aufnehmen_1m - Einen Clip meines Desktops genau eine Minute lang aufnehmen"
echo "53) Video_Aufnehmen_2m - Desktop-Aufnahme für zwei volle Minuten"
echo "54) Video_Aufnehmen_6m - Um mittlere Segmente von 6 Minuten aufzunehmen"
echo "55) Video_Aufnehmen_20m - Große ununterbrochene Aufnahmen in einem 20-Minuten-Zeitraum"
echo "56) Video_Aufnehmen_30m - Extrem, um eine Klasse für eine halbe Stunde aufzunehmen"
echo "57) Letzte_Aufn_Ansehen - Zuletzt aufgenommenes Video automatisch abspielen (MPV)"
echo "58) Sekunden_Uhr - Visuellen Fortschrittsbalken starten, zuerst nach Sekunden fragen"
echo "59) Minuten_Uhr - Spezifischer Balken, nach großer Zahl im direkten Minutenformat fragen"

echo ""
printf "Wähle eine Nummer oder gib den Befehl ein: "
read USER_INPUT

case "$USER_INPUT" in
    1|Aufloesung_Einstellen)
            MODELINE_NAME=$(cvt 1024 576 60 | awk '/Modeline/ {print $2}')
            MODELINE_PARAMS=$(cvt 1024 576 60 | awk '/Modeline/ {for(i=3;i<=NF;i++) printf $i " "; print ""}')
            xrandr --newmode $MODELINE_NAME $MODELINE_PARAMS
            xrandr --addmode eDP-1 $MODELINE_NAME
            xrandr --output eDP-1 --mode $MODELINE_NAME
            ;;
    2|Tastaturkürzel)
            xbindkeys
            ;;
    3|Zeit_Synchronisieren)
            doas ntpd
            ;;
    4|Bildschirmuhr)
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
    5|Monitore_Warten)
            if xrandr | grep -q ' DP-1 connected' ||
                    xrandr | grep -q 'DP-2 connected' ||
                    xrandr | grep -q 'HDMI-1 connected'; then
                sleep 5s
            fi
            ;;
    6|Thinkpad_Start)
            if doas dmesg | grep thinkpad > /dev/null; then
                sleep 2 && cd && bash literatura.sh && dash $HOME/monoliths-hm/autoinit.sh
                doas service dbus start; doas service bluetooth start
                ( sleep 3 && echo -e "power on\nexit" | bluetoothctl )
            fi
            ;;
    7|Auto_Tastatur)
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
    8|Konsolenaufloesung)
            ( [ -f /etc/default/grub.normal ] || doas cp /etc/default/grub /etc/default/grub.normal ) && \
                cat /etc/default/grub | grep -q '800x600' && \
                ( doas cp /etc/default/grub.normal /etc/default/grub ) || \
                    ( echo 'GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"' | doas tee -a /etc/default/grub && \
                          echo 'GRUB_GFXMODE=800x600' | doas tee -a /etc/default/grub && \
                          echo 'GRUB_GFXPAYLOAD_LINUX=keep' | doas tee -a /etc/default/grub ) && \
                        ( doas grub-mkconfig -o /boot/grub/grub.cfg && doas reboot )
            ;;
    9|Trackball_Kalibrieren)
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
    10|Batteriemonitor)
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
    11|Hinweis_Umschalten)
            [ -f "$HOME/.stop_personal_osdx" ] && rm "$HOME/.stop_personal_osdx" || touch "$HOME/.stop_personal_osdx"
            ;;
    12|Lautstaerkeregler)
            export DISPLAY=:0
            xterm -e 'alsamixer'
            ;;
    13|Pieptoene_Stumm)
            doas rmmod pcspkr
            ;;
    14|Tracking_Routine_A)
            HOUR=$(date +%H); if [ $HOUR -ge 10 -a $HOUR -lt 13 ]; then ( xtimemon -S 10:00 -E 13:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 19 ]; then ( xtimemon -S 14:00 -E 19:00 -p top ); fi
            ;;
    15|Tracking_Routine_B)
            HOUR=$(date +%H); if [ $HOUR -ge 10 -a $HOUR -lt 12 ]; then ( xtimemon -S 10:00 -E 12:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 20 ]; then ( xtimemon -S 14:00 -E 20:00 -p top ); fi
            ;;
    16|Tracking_Routine_C)
            HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 13 ]; then ( xtimemon -S 09:00 -E 13:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 18 ]; then ( xtimemon -S 14:00 -E 18:00 -p top ); fi
            ;;
    17|Tracking_Routine_D)
            HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 12 ]; then ( xtimemon -S 09:00 -E 12:00 -p top ); elif [ $HOUR -ge 14 -a $HOUR -lt 19 ]; then ( xtimemon -S 14:00 -E 19:00 -p top ); fi
            ;;
    18|Tracking_Routine_E)
            HOUR=$(date +%H); if [ $HOUR -ge 9 -a $HOUR -lt 12 ]; then ( xtimemon -S 09:00 -E 12:00 -p top ); elif [ $HOUR -ge 15 -a $HOUR -lt 20 ]; then ( xtimemon -S 15:00 -E 20:00 -p top ); fi
            ;;
    19|Nachtmodus_Monitor)
            for a in $(xrandr | grep ' connected' | awk '{print $1}'); do xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.2; done
            ;;
    20|Tagmodus_Monitor)
            for a in $(xrandr | grep ' connected' | awk '{print $1}'); do xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.4; done
            ;;
    21|Audio_Ueber_HDMI)
            doas service tor start && doas service sndiod start && sleep 1 && sndiod -f rsnd/0,3 && firefox > /dev/null 2>&1
            ;;
    22|Bluetooth_Einschalten)
            doas service dbus start; doas service bluetooth start
            ;;
    23|Bluetooth_Ausschalten)
            doas service dbus stop; doas service bluetooth stop
            ;;
    24|Spiegelkamera)
            ffplay -fflags nobuffer -flags low_delay -framedrop -vf 'crop=250:530:(iw-250)/2:(ih-530)/2,hflip' /dev/video0
            ;;
    25|Tracking_Routine_F)
            HOUR=$(date +%H); if [ $HOUR -ge 7 -a $HOUR -lt 10 ]; then ( xtimemon -S 7:20 -E 9:20 -p top ); fi
            ;;
    26|WLAN_Licht_Aus)
            ( echo 0 | doas tee /sys/class/leds/ath9k_htc-phy1/brightness || echo 0 | doas tee /sys/class/leds/ath9k_htc-phy0/brightness )
            ;;
    27|Bildschirm_Ausschalten_Sperren)
            xset s off && xset s noblank && xset -dpms
            ;;
    28|Natives_Lernen)
            cd $HOME/literatura && dash literatura.sh
            ;;
    29|Uebersetztes_Lernen)
            cd $HOME/literatura-to-es && dash literatura.sh
            ;;
    30|CapsLock_Deaktivieren)
            setxkbmap -option caps:none
            ;;
    31|Meine_Anleitung_Besuchen)
            bash /usr/share/fvwm3/default-config/c || chromium
            ;;
    32|VPN_Dienst)
            emacs --eval='(ofv)'
            ;;
    33|Experten_Geschwindigkeit)
            while true; do
                xset r rate 150 110
                sleep 1
            done
            ;;
    34|Akku_Leiste_Ausblenden)
            killall xbattmon
            ;;
    35|CapsLock_Aktivieren)
            setxkbmap -option
            ;;
    36|Anfaenger_Geschwindigkeit)
            while true; do
                xset r rate 140 60
                sleep 1
            done
            ;;
    37|Akku_Leiste_Anzeigen)
            xbattmon
            ;;
    38|Abmelden)
            doas killall X
            ;;
    39|Ausschalten)
            doas poweroff
            ;;
    40|Bildschirme_Konfigurieren)
            arandr
            ;;
    41|System_Neustarten)
            doas reboot
            ;;
    42|Lateinamerika_Layout)
            echo 'latam' > /tmp/layout.my
            while true; do
                LAYOUT=$(cat /tmp/layout.my)
                setxkbmap "$LAYOUT"
                sleep 1
            done
            ;;
    43|Emacs_Normal_Starten)
            emacs -mm
            ;;
    44|Aussprache)
            emacs -mm -q -Q --file=$HOME/monoliths-llm/text_english_training.el --eval='(eval-buffer)'
            if ! doas dmesg | grep thinkpad > /dev/null; then
                audacity
            fi
            ;;
    45|Deutsches_Layout)
            echo 'de' > /tmp/layout.my
            while true; do
                LAYOUT=$(cat /tmp/layout.my)
                setxkbmap "$LAYOUT"
                sleep 1
            done
            ;;
    46|Amerikanisches_Layout)
            echo 'us' > /tmp/layout.my
            while true; do
                LAYOUT=$(cat /tmp/layout.my)
                setxkbmap "$LAYOUT"
                sleep 1
            done
            ;;
    47|Spanien_Layout)
            echo 'es' > /tmp/layout.my
            while true; do
                LAYOUT=$(cat /tmp/layout.my)
                setxkbmap "$LAYOUT"
                sleep 1
            done
            ;;
    48|Emacs_Dev_Starten)
            emacs -mm -fg white -bg black -q -Q
            ;;
    49|ChatGPT_Assistent)
            chromium --app='https://chatgpt.com'
            ;;
    50|Dateien_Sichern)
            cd && dash saravia
            ;;
    51|YouTube_Oeffnen)
            chromium --app='https://youtube.com'
            ;;
    52|Video_Aufnehmen_1m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 1
            end=$((SECONDS + 1*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
    53|Video_Aufnehmen_2m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 2
            end=$((SECONDS + 2*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
    54|Video_Aufnehmen_6m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 6
            end=$((SECONDS + 6*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
    55|Video_Aufnehmen_20m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 20
            end=$((SECONDS + 20*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
    56|Video_Aufnehmen_30m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 30
            end=$((SECONDS + 30*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
    57|Letzte_Aufn_Ansehen)
            latest_video=$(ls -t "$HOME"/simplescreenrecorder-*.mkv 2>/dev/null | head -1)
            mpv "$latest_video"
            ;;
    58|Sekunden_Uhr)
            dash $HOME/monoliths-llm/simple_second_counter_xterm-N-yad.sh
            ;;
    59|Minuten_Uhr)
            dash $HOME/monoliths-llm/special_minute_counter_xtimemon-N-yad.sh
            ;;
    *)
        echo "Ungültige Option."
        exit 1
        ;;
esac
