#!/bin/dash
[ -f $HOME/.amixer_scontents ] && rm $HOME/.amixer_scontent*
echo $(amixer scontents Master | grep Playback) > $HOME/.amixer_scontents
emacs --batch -Q --eval="(progn (find-file \"$HOME/.amixer_scontents\") (setq last-kbd-macro (kbd \"M-d M-d M-d M-d M-d M-d M-d M-d M-d M-d C-d M-f C-f C-k C-x C-s\")) (call-last-kbd-macro) (save-buffers-kill-terminal 'silently))"
cat $HOME/.amixer_scontents
