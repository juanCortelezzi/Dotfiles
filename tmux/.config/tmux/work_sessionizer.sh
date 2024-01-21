#!/bin/bash

# check that tmux is installed
if ! [ -x "$(command -v tmux)" ]; then
  echo 'Error: tmux is not installed.' >&2
  exit 1
fi

DEV_SESSION="dev"
SERVERS_SESSION="servers"
NOTES_SESSION="notes"
DOCUMENTS_DIR="$HOME/Documents"
PROGRAMMING_DIR="$DOCUMENTS_DIR/programming"
NOTES_DIR="$DOCUMENTS_DIR/notes"

if tmux has-session -t $DEV_SESSION 2>/dev/null; then
  echo "Error: tmux session \"$DEV_SESSION\" already exists." >&2
  exit 1
fi

if tmux has-session -t $SERVERS_SESSION 2>/dev/null; then
  echo "Error: tmux session \"$SERVERS_SESSION\" already exists." >&2
  exit 1
fi

if tmux has-session -t $NOTES_SESSION 2>/dev/null; then
  echo "Error: tmux session \"$NOTES_SESSION\" already exists." >&2
  exit 1
fi

# # DEV SESSION
tmux new-session -d -s $DEV_SESSION

# SERVER SESSION
tmux new-session -d -s $SERVERS_SESSION
tmux new-window -k -t "$SERVERS_SESSION:1" -n "illuminate" -c "$PROGRAMMING_DIR/illuminate"

tmux new-window -k -t "$SERVERS_SESSION:2" -n "mono" -c "$PROGRAMMING_DIR/rocket-monorepo/apps/web"
tmux split-window -t "$SERVERS_SESSION:2" -h -c "$PROGRAMMING_DIR/rocket-monorepo/apps/admin"
tmux split-window -t "$SERVERS_SESSION:2" -v -c "$PROGRAMMING_DIR/rocket-monorepo/apps/web"
tmux select-pane -t 1

tmux new-window -k -t "$SERVERS_SESSION:3" -n "app" -c "$PROGRAMMING_DIR/rocket-app"
tmux new-window -k -t "$SERVERS_SESSION:4" -n "rocketeer" "$PROGRAMMING_DIR/rocketeer"

tmus select-window -t "$SERVERS_SESSION:1"

# NOTES SESSION
tmux new-session -d -s $NOTES_SESSION
tmux new-window -d -k -t "$NOTES_SESSION:1" -n "markdown" -c "$NOTES_DIR/markdown"
tmux new-window -d -k -t "$NOTES_SESSION:2" -n "obsidian" -c "$NOTES_DIR/obsidian/origin"

tmux attach-session -t $DEV_SESSION



