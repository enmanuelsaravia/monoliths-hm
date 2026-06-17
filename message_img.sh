#!/bin/dash

tempfile=$(mktemp)
F="${tempfile}.png"
[ -f $F ] && rm $F

message_img() {
text="$1"

# 1. Obtener la resolución de la pantalla
resolution=$(xrandr 2>/dev/null | grep '*' | sed 's/.* \([0-9]\+x[0-9]\+\).*/\1/')
width=$(echo $resolution | cut -dx -f1)
width=${width#\"}
height=$(echo $resolution | cut -dx -f2)
height=${height%%_*}

# 2. Configuración para ImageMagick
point_size=30

# Crear imagen blanca del tamaño de pantalla y dibujar texto centrado
convert -size "${width}x${height}" xc:white \
    -font '/usr/share/fonts/liberation/LiberationSans-BoldItalic.ttf' \
    -pointsize $point_size \
    -fill black \
    -gravity center \
    -draw "text 0,0 '$text'" \
    "$F"

pgrep feh | xargs kill > /dev/null 2>&1 &
sleep 0.1
feh --borderless "$F" > /dev/null 2>&1 &
}

# Llama a la función con el texto de ejemplo
# Nota: La llamada al final del script depende de cómo lo ejecutes. 
# Si el texto de ejemplo es lo que quieres probar:
# message_img "qué gastos tienen; y sabiendo por estos rodeos y preguntas indirectas que conocen á mi hijo, no se vio despues de conocen"

# Mantenemos la llamada original para que funcione con tu flujo de trabajo:
message_img "$1"