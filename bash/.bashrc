# OPENSPEC:START
# OpenSpec shell completions configuration
if [ -d "/home/krzysiek-dev/.local/share/bash-completion/completions" ]; then
  for f in "/home/krzysiek-dev/.local/share/bash-completion/completions"/*; do
    [ -f "$f" ] && . "$f"
  done
fi
# OPENSPEC:END

#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# --------------------------------------------------------------------------
# ble.sh -- Bash Line Editor (syntax highlighting, autosuggestions, vi mode)
# --------------------------------------------------------------------------
[[ $- == *i* ]] && source -- ~/.local/share/blesh/ble.sh --attach=none

# --------------------------------------------------------------------------
# Shell options
# --------------------------------------------------------------------------
set -o vi

# --------------------------------------------------------------------------
# Environment variables
# --------------------------------------------------------------------------
# Only override TERM inside tmux (Ghostty sets its own xterm-ghostty)
[[ -n "$TMUX" ]] && export TERM="tmux-256color"
export EDITOR="nvim"

# --------------------------------------------------------------------------
# PATH
# --------------------------------------------------------------------------
_dirs_to_add=(
    "$HOME/bin"
    "$HOME/.local/bin"
    "/usr/local/bin"
    "/usr/sbin"
    "$HOME/.local/share/fnm"
    "$HOME/.phpenv/bin"
    "$HOME/.config/composer/vendor/bin"
    "$HOME/.local/share/mise/shims"
)

for _dir in "${_dirs_to_add[@]}"; do
    [[ -d "$_dir" ]] && PATH="$_dir:$PATH"
done
unset _dir _dirs_to_add

# --------------------------------------------------------------------------
# phpenv
# --------------------------------------------------------------------------
export PHPENV_ROOT="$HOME/.phpenv"
if [[ -d "$PHPENV_ROOT" ]]; then
    export PATH="$PHPENV_ROOT/bin:$PATH"
    eval "$(phpenv init -)"
fi

# --------------------------------------------------------------------------
# mise (runtime version manager)
# --------------------------------------------------------------------------
if command -v mise &>/dev/null; then
    eval "$(mise activate bash)"
fi

# --------------------------------------------------------------------------
# Starship prompt
# --------------------------------------------------------------------------
if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi

# --------------------------------------------------------------------------
# zoxide (smart cd)
# --------------------------------------------------------------------------
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init bash)"
fi

# --------------------------------------------------------------------------
# Source modular config files
# --------------------------------------------------------------------------
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
[[ -f ~/.bash_functions ]] && source ~/.bash_functions

# --------------------------------------------------------------------------
# ble.sh attach (must be last)
# --------------------------------------------------------------------------
[[ ! ${BLE_VERSION-} ]] || ble-attach
eval "$(direnv hook bash)"

# Android SDK (pj-mobile / port-to-android)
# JDK 21, not 17: @capacitor/android 7.x pins JavaVersion.VERSION_21, so a
# 17 toolchain fails the build outright (and leaves an unusable Gradle daemon).
# JAVA_HOME is exported by mise (java = temurin-21 in mise/config.toml)
export ANDROID_HOME="$HOME/Android"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
