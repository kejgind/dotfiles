#
# ~/.bash_aliases
#

# Directory listing (eza)
alias edir='eza -1 -l -g --time-style long-iso --git-ignore --ignore-glob "cache|vendor|node_modules"'
alias edirs='eza -1 -l -g --total-size --time-style long-iso --git-ignore --ignore-glob "cache|vendor|node_modules"'
alias etree='eza -T -l -g --time-style long-iso --git-ignore --ignore-glob "cache|vendor|node_modules"'

# Defaults
alias ls='ls --color=auto'
alias grep='grep --color=auto'
