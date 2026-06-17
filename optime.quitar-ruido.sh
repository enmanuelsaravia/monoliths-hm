#!/bin/dash

if command -v ffmpeg > /dev/null && \
		ffmpeg -y -i "$1" /tmp/audio.aac && \
		sleep 0.5 && [ -f '/tmp/audio.aac' ]; then
    
    # Notificación
    herbe 'Guarda el resultado como /tmp/audio.mp3' & 
    audacity /tmp/audio.aac
    
    if ffmpeg -y -i '/tmp/audio.mp3' -b:a 64k '/tmp/output.aac' && \
			sleep 0.5 && [ -f '/tmp/output.aac' ]; then
        
        if ffmpeg -y -i "$1" -vcodec copy -an "/tmp/$1" && \
				sleep 0.5 && [ -f "/tmp/$1" ]; then
            
            # ffmpeg -y -i "/tmp/$1" -i "/tmp/output.aac" -c copy -map 0:v:0 -map 1:a:0 "$PWD/fixed-audio-${1}"
            ffmpeg -y -i "/tmp/$1" -i '/tmp/output.aac' \
			 	   -c:v libx264 -c:a copy -map 0:v:0 -map 1:a:0 "$PWD/fixed-audio-${1}"
        fi
    fi
fi
