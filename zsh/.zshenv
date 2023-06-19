# zsh config
ZDOTDIR=$HOME/.config/zsh

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}

export LANG=en_US.UTF-8
export TERM='xterm-256color'
export TERMINAL="st"
export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="firefox"

# add npm globals to path
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export VOLTA_HOME="$XDG_CONFIG_HOME/volta"
export PATH="$VOLTA_HOME/bin:$PATH"
# SDK man
# export SDKMAN_DIR="$XDG_CONFIG_HOME/sdkman"
# export NPM_CONFIG_PREFIX="$XDG_CONFIG_HOME/npm/npm-global"
# export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"
# add Android SDK to path
# export ANDROID_HOME=$HOME/Android/Sdk
# export ANDROID_SDK_ROOT=$ANDROID_HOME
# export ANDROID_PREFS_ROOT=$HOME/.android
# export ANDROID_EMULATOR_HOME=$HOME/.android
# export ANDROID_AVD_HOME=$ANDROID_EMULATOR_HOME/avd
# export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
# export PATH=$PATH:$ANDROID_SDK_ROOT/tools
# export PATH=$PATH:$ANDROID_SDK_ROOT/tools/bin
# export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools
# Haskell
# export CABAL_CONFIG="$XDG_CONFIG_HOME/cabal/config"
# export GHCUP_USE_XDG_DIRS=true # set to anything
# add cargo/rust to path
# Ansible
export ANSIBLE_HOME="$XDG_CONFIG_HOME/ansible"
export RUSTUP_HOME="$XDG_CONFIG_HOME/rust/rustup"
export CARGO_HOME="$XDG_CONFIG_HOME/rust/cargo"
export PATH="$CARGO_HOME/bin:$PATH"
# add go to path
export GOPATH="$HOME/Documents/Golang-programmes/gopath"
export PATH="$GOPATH/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
# pass password storage
export PASSWORD_STORE_DIR="$XDG_CONFIG_HOME/pass-store"
# gtk2rc to .config
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
# gnupg to .config
export GNUPGHOME="$XDG_CONFIG_HOME/gnupg"
# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-R
# No hist file
export LESSHISTFILE="-"
