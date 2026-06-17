#!/bin/dash
[ -h $HOME/.#.amixer_scontents ] && rm -f $HOME/.#.amixer_scontent*
[ -h $HOME/.#.amixer_scontrols ] && rm -f $HOME/.#.amixer_scontrol*
[ -f $HOME/.amixer_scontrols ] && rm -f $HOME/.amixer_scontrols
[ -f $HOME/.amixer_scontrols ] && rm -f $HOME/.amixer_scontents
[ -f $HOME/.amixer_scontrols~ ] && rm -f $HOME/.amixer_scontrols~
[ -f $HOME/.amixer_scontrols~ ] && rm -f $HOME/.amixer_scontents~
echo $(amixer scontrols) > $HOME/.amixer_scontrols
emacs --batch -Q --eval="(progn (find-file \"$HOME/.amixer_scontrols\") (setq last-kbd-macro (kbd \"M-d M-d M-d C-d C-d M-f C-k C-x C-s\")) (call-last-kbd-macro) (save-buffers-kill-terminal 'silently))"
if echo -n "$(cat $HOME/.amixer_scontrols)" | grep -q PCM; then
    amixer sset "$(cat $HOME/.amixer_scontrols)" 0 %100
    amixer sset "$(cat $HOME/.amixer_scontrols)" 1 %100
else
    amixer sset "$(cat $HOME/.amixer_scontrols)" %100
fi
