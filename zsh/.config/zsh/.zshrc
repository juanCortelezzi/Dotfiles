USE_PROMPT="wiz" # spaceship, typewritten or wiz
HISTFILE=~/.cache/zsh/zhistory
HISTSIZE=5000
SAVEHIST=5000
WORDCHARS=${WORDCHARS//\/[&.;]} # Don't consider certain characters part of the word

## Options section
# setopt autocd               # if only directory path is entered, cd there.
setopt extendedglob           # Extended globbing. Allows using regular expressions with *
setopt nocaseglob             # Case insensitive globbing
setopt rcexpandparam          # Array expension with parameters
setopt nocheckjobs            # Don't warn about running processes when exiting
setopt numericglobsort        # Sort filenames numerically when it makes sense
setopt nobeep                 # No beep
setopt appendhistory          # Immediately append history instead of overwriting
setopt histignorealldups      # If a new command is a duplicate, remove the older one
setopt inc_append_history     # save commands are added to the history immediately, otherwise only when shell exits.

# Theming section
autoload -U compinit && compinit -d ~/.config/zsh/zcompdump
# autoload -U colors && colors
# autoload -U zcalc

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "^k" up-line-or-beginning-search # Up
bindkey "^j" down-line-or-beginning-search # Down

zmodload zsh/complist
_comp_options+=(globdots)

# Speed up completions
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcache"

# Proper delete key
# bindkey -a '^[[3~' vi-delete-char

# Useful funcions
source "$ZDOTDIR/zsh-functions"

# Load aliases and shortcuts if existent.
zsh_add_file "zsh-aliases"
zsh_add_file "promptConfig/zsh-prompt"
zsh_add_file "zsh-vim-mode"

# Load pluggins
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern regexp)

typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta,bold'

ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=9'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=9'
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow,underline'
ZSH_HIGHLIGHT_STYLES[unknown-token]='none'

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666,bold,underline"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=40
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# Opam init shit
[[ ! -r "$XDG_DATA_HOME/opam/opam-init/init.zsh" ]] || source "$XDG_DATA_HOME/opam/opam-init/init.zsh"  > /dev/null 2> /dev/null
