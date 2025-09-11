#!/bin/bash

DEFAULT_DIR="$HOME/projects/go/ghtrend"  
SESSION_NAME="ghtrend"

tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
    tmux new-session -d -s $SESSION_NAME -c $DEFAULT_DIR
    tmux rename-window -t $SESSION_NAME:1 'cmd'

    tmux new-window -t $SESSION_NAME:2 -n 'nvim' -c $DEFAULT_DIR
    tmux send-keys -t $SESSION_NAME:2 'nvim .' C-m
fi

tmux attach-session -t $SESSION_NAME


