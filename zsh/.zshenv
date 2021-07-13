# zsh config
ZDOTDIR=$HOME/.config/zsh

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}

export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"

export LANG=en_US.UTF-8
export TERM='tmux-256color'
export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="firefox"
