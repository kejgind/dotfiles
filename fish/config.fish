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
    path filter $HOME/bin $HOME/.local/bin /usr/local/bin /usr/sbin $HOME/.local/share/fnm $HOME/.phpenv/bin
)

function sail
    if test -f sail
        sh sail $argv
    else
        sh vendor/bin/sail $argv
    end
end

set -x PHPENV_ROOT "$HOME/.phpenv"
if test -d "$PHPENV_ROOT"
    set -x PATH "$PHPENV_ROOT/bin" $PATH
    status --is-interactive; and source (phpenv init -|psub)
end

function php74
    docker run --rm --interactive --tty --volume pwd:/app -w /app php:7.4-cli php $argv
end

function php82
    docker run --rm --interactive --tty --volume pwd:/app -w /app php:8.2-cli php $argv
end

function php83
    docker run --rm --interactive --tty --volume pwd:/app -w /app php:8.3-cli php $argv
end

function php84
    docker run --rm --interactive --tty --volume pwd:/app -w /app php:8.4-cli php $argv
end

function composer83
    docker run --rm --interactive --tty --volume pwd:/app composer/composer:2.8.3 $argv
end

function node20
    docker run --rm -v (pwd)"/":/app -w /app --user (id -u):(id -g) node:20-alpine /bin/sh -c (printf "'%s' " $argv)
end

function node22
    docker run --rm -v (pwd)"/":/app -w /app --user (id -u):(id -g) node:22-alpine /bin/sh -c (printf "'%s' " $argv)
end

function bunrun
    docker run --rm -v (pwd)"/":/app -w /app --user (id -u):(id -g) oven/bun:1-alpine /bin/sh -c (printf "'%s' " $argv)
end

starship init fish | source
