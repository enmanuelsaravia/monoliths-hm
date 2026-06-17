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
    amixer set "$(cat $HOME/.amixer_scontrols)" 0 5+
    amixer set "$(cat $HOME/.amixer_scontrols)" 1 5+
else
    amixer set "$(cat $HOME/.amixer_scontrols)" 5+
fi
echo $(amixer scontents Master | grep Playback) > $HOME/.amixer_scontents
emacs --batch -Q --eval="(progn (find-file \"$HOME/.amixer_scontents\") (setq last-kbd-macro (kbd \"M-d M-d M-d M-d M-d M-d M-d M-d M-d M-d C-d M-f C-f C-k C-x C-s\")) (call-last-kbd-macro) (save-buffers-kill-terminal 'silently))"
