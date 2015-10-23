#!/bin/bash

EVAL="
(progn
	(setq load-path
		(cons \"erlang_mode\" load-path))
    (require 'erlang-start)
    (erlang-mode)
"

if [[ -f $1 ]]; then
	EVAL+="
	(find-file \"$1\")
    (untabify (point-min) (point-max))
    (delete-trailing-whitespace)
    (erlang-indent-current-buffer)
    (untabify (point-min) (point-max))
    (if (buffer-modified-p)
    	(save-buffer))
	(kill-buffer)
	"
elif [[ -d $1 ]]; then
	for f in "$1"/*.erl; do
		EVAL+="
		(find-file \"$f\")
	    (untabify (point-min) (point-max))
	    (delete-trailing-whitespace)
	    (erlang-indent-current-buffer)
            (untabify (point-min) (point-max))
	    (if (buffer-modified-p)
	    	(save-buffer))
		(kill-buffer)
		"
	done
else
	echo "Usage: $0 [ <file> | <folder> ]"
	exit
fi

EVAL+="
    (kill-emacs))
"

emacs -q --batch --eval "${EVAL}"
