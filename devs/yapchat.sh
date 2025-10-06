#!/bin/bash

DEFAULT_DIR="$HOME/projects/ts/YapYap-ChatApp"  
SESSION_NAME="yapchat"

tmux has-session -t $SESSION_NAME 2>/dev/null

if [ $? != 0 ]; then
    tmux new-session -d -s $SESSION_NAME -c $DEFAULT_DIR
    tmux rename-window -t $SESSION_NAME:1 'nvim'
    tmux send-keys -t $SESSION_NAME:1 'nvim .' C-m

    tmux new-window -t $SESSION_NAME:2 -n 'cmd' -c $DEFAULT_DIR
    tmux send-keys -t $SESSION_NAME:2 'npm run dev' C-m

    tmux new-window -t $SESSION_NAME:3 -n 'socket' -c $DEFAULT_DIR
    tmux send-keys -t $SESSION_NAME:3 'cd ws && npm run start' C-m
fi

tmux attach-session -t $SESSION_NAME


