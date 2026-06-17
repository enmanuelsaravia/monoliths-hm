#!/bin/dash

echo "=== Options List ==="
echo ""
echo "1) Set_Resolution - Configure display to 1024x576 at 60Hz"
echo "2) Keyboard_Shortcuts - Start custom shortcuts daemon (xbindkeys)"
echo "3) Sync_Time - Adjust system clock via network (ntpd)"
echo "4) Screen_Clock - Show a permanent clock in the corner"
echo "5) Wait_Monitors - Pause 5 sec if external monitors connected"
echo "6) Thinkpad_Startup - Execute automatic startup for Thinkpad (BT/Scripts)"
echo "7) Auto_Keyboard - Force Latam layout continuously and toggle CapsLock"
echo "8) Console_Resolution - Reboot PC to fix font size in terminal (TTY)"
echo "9) Calibrate_Trackball - Accelerate the TrackBall Mouse slightly more"
echo "10) Battery_Monitor - Track battery level and time in OSD"
echo "11) Toggle_Notice - Hide/Show the permanent OSD time notice"
echo "12) Volume_Control - Open sound mixer in terminal (Alsamixer)"
echo "13) Silence_Beeps - Remove annoying system 'beep' sound (pcspkr)"
echo "14) Tracking_Routine_A - Track productivity via xtimemon from [10-13, 14-19]"
echo "15) Tracking_Routine_B - Track productivity via xtimemon from [10-12, 14-20]"
echo "16) Tracking_Routine_C - Track productivity via xtimemon from [09-13, 14-18]"
echo "17) Tracking_Routine_D - Track productivity via xtimemon from [09-12, 14-19]"
echo "18) Tracking_Routine_E - Track productivity via xtimemon from [09-12, 15-20]"
echo "19) Night_Mode_Monitor - Reduce all brightness to 0.2 to avoid visual fatigue"
echo "20) Day_Mode_Monitor - Increase illumination to 0.4 for very bright rooms"
echo "21) Audio_Via_HDMI - Route sound to TV (HDMI) and open Firefox"
echo "22) Turn_On_Bluetooth - Start managers and activate Bluetooth connectivity"
echo "23) Turn_Off_Bluetooth - Stop dbus manager and disable Bluetooth consumption"
echo "24) Mirror_Camera - Project front webcam to bottom corner, inverted image"
echo "25) Tracking_Routine_F - Extreme morning tracking using xtimemon from [07-09]"
echo "26) Turn_Off_Wifi_Light - Turn off annoying LED of the TP-Link USB device"
echo "27) Block_Screen_Off - Prevent screen from going black after inactivity"
echo "28) Native_Study - Start literature program in original language"
echo "29) Translated_Study - Start literature program translated to Spanish"
echo "30) Disable_CapsLock - Disable CapsLock key for comfortable typing"
echo "31) Visit_My_Guide - View base FVWM shortcuts reading the html in browser"
echo "32) VPN_Service - Start virtual private network connectivity from emacs buffer"
echo "33) Expert_Speed - Make key repetition extremely fast on press"
echo "34) Hide_Bat_Bar - Close the bottom green/red battery bar"
echo "35) Enable_CapsLock - Restore normal CapsLock key functionality"
echo "36) Novice_Speed - Repeat each letter slower on sustained press"
echo "37) Show_Bat_Bar - Restart battery level bar on screen"
echo "38) Log_Out - Kill open apps and drop from X server to login manager"
echo "39) Power_Off - Close daemons and permanently power off hardware"
echo "40) Configure_Screens - Launch 'Arandr' to visually adjust connected monitors"
echo "41) Reboot_System - Perform controlled shutdown and immediately turn on computer"
echo "42) Latin_America_Layout - Change keyboard map to typical Latin America layout"
echo "43) Launch_Emacs_Normal - Start main full instance of Emacs text editor"
echo "44) Pronunciation - Practice reading line-by-line with voice in Emacs (TTS)"
echo "45) German_Layout - Change keyboard layout to German distribution (QWERTZ)"
echo "46) American_Layout - Change map to USA English distribution"
echo "47) Spain_Layout - Change keyboard to classic Spain layout"
echo "48) Launch_Emacs_Dev - Fast load of empty Emacs with visually black background"
echo "49) ChatGPT_Assistant - Open official smart chat bot web app in Chromium"
echo "50) Backup_Files - Send local modifications to backup using custom git code"
echo "51) Open_YouTube - Launch YouTube page using integrated browser"
echo "52) Record_Video_1m - Make a clip recording my desktop just for one continuous minute"
echo "53) Record_Video_2m - Capture desktop recording for two solid minutes"
echo "54) Record_Video_6m - To record medium segments equivalent to 6 minutes"
echo "55) Record_Video_20m - Large uninterrupted captures in a twenty-minute period"
echo "56) Record_Video_30m - Extreme to capture class for a half-hour period"
echo "57) Watch_Last_Recording - Automatically play your last recorded video (MPV)"
echo "58) Seconds_Clock - Launch visual progress bar asking for seconds count first"
echo "59) Minutes_Clock - Specific bar asking for large count in direct minutes format"

echo ""
printf "Choose a number or type the command: "
read USER_INPUT

case "$USER_INPUT" in
    1|Set_Resolution)
            MODELINE_NAME=$(cvt 1024 576 60 | awk '/Modeline/ {print $2}')
            MODELINE_PARAMS=$(cvt 1024 576 60 | awk '/Modeline/ {for(i=3;i<=NF;i++) printf $i " "; print ""}')
            xrandr --newmode $MODELINE_NAME $MODELINE_PARAMS
            xrandr --addmode eDP-1 $MODELINE_NAME
            xrandr --output eDP-1 --mode $MODELINE_NAME
            ;;
    2|Keyboard_Shortcuts)
            xbindkeys
            ;;
    3|Sync_Time)
            doas ntpd
            ;;
    4|Screen_Clock)
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
    5|Wait_Monitors)
            if xrandr | grep -q ' DP-1 connected' ||
                    xrandr | grep -q 'DP-2 connected' ||
                    xrandr | grep -q 'HDMI-1 connected'; then
                sleep 5s
            fi
            ;;
    6|Thinkpad_Startup)
            if doas dmesg | grep thinkpad > /dev/null; then
                sleep 2 && cd && bash literatura.sh && dash $HOME/monoliths-hm/autoinit.sh
                doas service dbus start; doas service bluetooth start
                ( sleep 3 && echo -e "power on\nexit" | bluetoothctl )
            fi
            ;;
    7|Auto_Keyboard)
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
    8|Console_Resolution)
            ( [ -f /etc/default/grub.normal ] || doas cp /etc/default/grub /etc/default/grub.normal ) && \
                cat /etc/default/grub | grep -q '800x600' && \
                ( doas cp /etc/default/grub.normal /etc/default/grub ) || \
                    ( echo 'GRUB_CMDLINE_LINUX_DEFAULT="nomodeset"' | doas tee -a /etc/default/grub && \
                          echo 'GRUB_GFXMODE=800x600' | doas tee -a /etc/default/grub && \
                          echo 'GRUB_GFXPAYLOAD_LINUX=keep' | doas tee -a /etc/default/grub ) && \
                        ( doas grub-mkconfig -o /boot/grub/grub.cfg && doas reboot )
            ;;
    9|Calibrate_Trackball)
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
    10|Battery_Monitor)
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
    11|Toggle_Notice)
            [ -f "$HOME/.stop_personal_osdx" ] && rm "$HOME/.stop_personal_osdx" || touch "$HOME/.stop_personal_osdx"
            ;;
    12|Volume_Control)
            export DISPLAY=:0
            xterm -e 'alsamixer'
            ;;
    13|Silence_Beeps)
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
    19|Night_Mode_Monitor)
            for a in $(xrandr | grep ' connected' | awk '{print $1}'); do xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.2; done
            ;;
    20|Day_Mode_Monitor)
            for a in $(xrandr | grep ' connected' | awk '{print $1}'); do xrandr --output "$a" --gamma 1:0.9:0.8 --brightness 0.4; done
            ;;
    21|Audio_Via_HDMI)
            doas service tor start && doas service sndiod start && sleep 1 && sndiod -f rsnd/0,3 && firefox > /dev/null 2>&1
            ;;
    22|Turn_On_Bluetooth)
            doas service dbus start; doas service bluetooth start
            ;;
    23|Turn_Off_Bluetooth)
            doas service dbus stop; doas service bluetooth stop
            ;;
    24|Mirror_Camera)
            ffplay -fflags nobuffer -flags low_delay -framedrop -vf 'crop=250:530:(iw-250)/2:(ih-530)/2,hflip' /dev/video0
            ;;
    25|Tracking_Routine_F)
            HOUR=$(date +%H); if [ $HOUR -ge 7 -a $HOUR -lt 10 ]; then ( xtimemon -S 7:20 -E 9:20 -p top ); fi
            ;;
    26|Turn_Off_Wifi_Light)
            ( echo 0 | doas tee /sys/class/leds/ath9k_htc-phy1/brightness || echo 0 | doas tee /sys/class/leds/ath9k_htc-phy0/brightness )
            ;;
    27|Block_Screen_Off)
            xset s off && xset s noblank && xset -dpms
            ;;
    28|Native_Study)
            cd $HOME/literatura && dash literatura.sh
            ;;
    29|Translated_Study)
            cd $HOME/literatura-to-es && dash literatura.sh
            ;;
    30|Disable_CapsLock)
            setxkbmap -option caps:none
            ;;
    31|Visit_My_Guide)
            bash /usr/share/fvwm3/default-config/c || chromium
            ;;
    32|VPN_Service)
            emacs --eval='(ofv)'
            ;;
    33|Expert_Speed)
            while true; do
                xset r rate 150 110
                sleep 1
            done
            ;;
    34|Hide_Bat_Bar)
            killall xbattmon
            ;;
    35|Enable_CapsLock)
            setxkbmap -option
            ;;
    36|Novice_Speed)
            while true; do
                xset r rate 140 60
                sleep 1
            done
            ;;
    37|Show_Bat_Bar)
            xbattmon
            ;;
    38|Log_Out)
            doas killall X
            ;;
    39|Power_Off)
            doas poweroff
            ;;
    40|Configure_Screens)
            arandr
            ;;
    41|Reboot_System)
            doas reboot
            ;;
    42|Latin_America_Layout)
            echo 'latam' > /tmp/layout.my
            while true; do
                LAYOUT=$(cat /tmp/layout.my)
                setxkbmap "$LAYOUT"
                sleep 1
            done
            ;;
    43|Launch_Emacs_Normal)
            emacs -mm
            ;;
    44|Pronunciation)
            emacs -mm -q -Q --file=$HOME/monoliths-llm/text_english_training.el --eval='(eval-buffer)'
            if ! doas dmesg | grep thinkpad > /dev/null; then
                audacity
            fi
            ;;
    45|German_Layout)
            echo 'de' > /tmp/layout.my
            while true; do
                LAYOUT=$(cat /tmp/layout.my)
                setxkbmap "$LAYOUT"
                sleep 1
            done
            ;;
    46|American_Layout)
            echo 'us' > /tmp/layout.my
            while true; do
                LAYOUT=$(cat /tmp/layout.my)
                setxkbmap "$LAYOUT"
                sleep 1
            done
            ;;
    47|Spain_Layout)
            echo 'es' > /tmp/layout.my
            while true; do
                LAYOUT=$(cat /tmp/layout.my)
                setxkbmap "$LAYOUT"
                sleep 1
            done
            ;;
    48|Launch_Emacs_Dev)
            emacs -mm -fg white -bg black -q -Q
            ;;
    49|ChatGPT_Assistant)
            chromium --app='https://chatgpt.com'
            ;;
    50|Backup_Files)
            cd && dash saravia
            ;;
    51|Open_YouTube)
            chromium --app='https://youtube.com'
            ;;
    52|Record_Video_1m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 1
            end=$((SECONDS + 1*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
    53|Record_Video_2m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 2
            end=$((SECONDS + 2*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
    54|Record_Video_6m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 6
            end=$((SECONDS + 6*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
    55|Record_Video_20m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 20
            end=$((SECONDS + 20*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
    56|Record_Video_30m)
            dash $HOME/monoliths-llm/rec-to-certain-min.sh 30
            end=$((SECONDS + 30*60))
            while [ $SECONDS -lt $end ]; do
                [ -e /tmp/.stop ] && break
                sleep 1
            done
            sleep 10
            ;;
    57|Watch_Last_Recording)
            latest_video=$(ls -t "$HOME"/simplescreenrecorder-*.mkv 2>/dev/null | head -1)
            mpv "$latest_video"
            ;;
    58|Seconds_Clock)
            dash $HOME/monoliths-llm/simple_second_counter_xterm-N-yad.sh
            ;;
    59|Minutes_Clock)
            dash $HOME/monoliths-llm/special_minute_counter_xtimemon-N-yad.sh
            ;;
    *)
        echo "Invalid option."
        exit 1
        ;;
esac
