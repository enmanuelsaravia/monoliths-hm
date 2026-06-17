#!/bin/dash
for f in *.png; do
    convert "$f" -resize 16x16\! "tmp_$f" && mv "tmp_$f" "$f"
done