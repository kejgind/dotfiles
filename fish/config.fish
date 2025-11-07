set -Ux TERM "tmux-256color"

# name: 'Catppuccin Mocha'
# url: 'https://github.com/catppuccin/fish'
# preferred_background: 1e1e2e

set -g fish_color_normal cdd6f4
set -g fish_color_command 89b4fa
set -g fish_color_param f2cdcd
set -g fish_color_keyword f38ba8
set -g fish_color_quote a6e3a1
set -g fish_color_redirection f5c2e7
set -g fish_color_end fab387
set -g fish_color_comment 7f849c
set -g fish_color_error f38ba8
set -g fish_color_gray 6c7086
set -g fish_color_selection --background=313244
set -g fish_color_search_match --background=313244
set -g fish_color_option a6e3a1
set -g fish_color_operator f5c2e7
set -g fish_color_escape eba0ac
set -g fish_color_autosuggestion 6c7086
set -g fish_color_cancel f38ba8
set -g fish_color_cwd f9e2af
set -g fish_color_user 94e2d5
set -g fish_color_host 89b4fa
set -g fish_color_host_remote a6e3a1
set -g fish_color_status f38ba8
set -g fish_pager_color_progress 6c7086
set -g fish_pager_color_prefix f5c2e7
set -g fish_pager_color_completion cdd6f4
set -g fish_pager_color_description 6c7086

set -g fish_key_bindings fish_vi_key_bindings

# Add bin directories to path.
fish_add_path --prepend (
    path filter $HOME/bin $HOME/.local/bin /usr/local/bin /usr/sbin $HOME/.local/share/fnm $HOME/.phpenv/bin $HOME/.config/composer/vendor/bin
)

set -x PHPENV_ROOT "$HOME/.phpenv"
if test -d "$PHPENV_ROOT"
    set -x PATH "$PHPENV_ROOT/bin" $PATH
    status --is-interactive; and source (phpenv init -|psub)
end

if status is-interactive
  mise activate fish | source
else
  mise activate fish --shims | source
end

set -gx EDITOR "nvim"

starship init fish | source
mise activate fish | source
~/.local/bin/mise activate fish | source
zoxide init fish | source

# opencode
fish_add_path /home/krzysiek/.opencode/bin
