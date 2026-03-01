#
# ~/.bash_functions
#

# --------------------------------------------------------------------------
# Docker-based PHP runners
# --------------------------------------------------------------------------
php74() {
    docker run --rm --interactive --tty --volume "$(pwd)":/app -w /app php:7.4-cli php "$@"
}

php82() {
    docker run --rm --interactive --tty --volume "$(pwd)":/app -w /app php:8.2-cli php "$@"
}

php83() {
    docker run --rm --interactive --tty --volume "$(pwd)":/app -w /app php:8.3-cli php "$@"
}

php84() {
    docker run --rm --interactive --tty --volume "$(pwd)":/app -w /app php:8.4-cli php "$@"
}

# --------------------------------------------------------------------------
# Docker-based Node runners
# --------------------------------------------------------------------------
node20() {
    docker run --rm -v "$(pwd)/:/app" -w /app --user "$(id -u):$(id -g)" node:20-alpine /bin/sh -c "$(printf "'%s' " "$@")"
}

node22() {
    docker run --rm -v "$(pwd)/:/app" -w /app --user "$(id -u):$(id -g)" node:22-alpine /bin/sh -c "$(printf "'%s' " "$@")"
}

# --------------------------------------------------------------------------
# Docker-based Bun runner
# --------------------------------------------------------------------------
bunrun() {
    docker run --rm -v "$(pwd)/:/app" -w /app --user "$(id -u):$(id -g)" oven/bun:1-alpine /bin/sh -c "$(printf "'%s' " "$@")"
}

# --------------------------------------------------------------------------
# Composer
# --------------------------------------------------------------------------
composer() {
    local php_prefix
    php_prefix="$(mise where "vfox:mise-plugins/vfox-php")"
    php "$php_prefix/bin/composer" "$@"
}

composer83() {
    docker run --rm --interactive --tty --volume "$(pwd)":/app composer/composer:2.8.3 "$@"
}

# --------------------------------------------------------------------------
# Laravel Sail
# --------------------------------------------------------------------------
sail() {
    if [[ -f sail ]]; then
        sh sail "$@"
    else
        sh vendor/bin/sail "$@"
    fi
}

# --------------------------------------------------------------------------
# WordPress CLI
# --------------------------------------------------------------------------
wp() {
    export WP_CLI_MYSQL="docker exec -i mysql mysql"
    /usr/local/bin/wp "$@"
}

# --------------------------------------------------------------------------
# PHP-FPM (mise-installed, foreground)
# --------------------------------------------------------------------------
startphp() {
    local php_prefix
    php_prefix="$(mise where "vfox:mise-plugins/vfox-php")"
    "$php_prefix/sbin/php-fpm" --nodaemonize --fpm-config "$php_prefix/php-fpm.conf"
}

# --------------------------------------------------------------------------
# Tmux path shortener (abbreviate parent dirs to first char)
# --------------------------------------------------------------------------
tmux_path() {
    local path="${1:-$(pwd)}"

    # Replace $HOME with ~
    if [[ "$path" == "$HOME"* ]]; then
        path="~${path#$HOME}"
    fi

    # Split path, shorten all but last component
    local IFS='/'
    read -ra dirs <<< "$path"
    local short_path=""
    local last_idx=$(( ${#dirs[@]} - 1 ))

    for i in "${!dirs[@]}"; do
        if (( i == last_idx )); then
            short_path+="${dirs[$i]}"
        elif [[ -n "${dirs[$i]}" ]]; then
            short_path+="${dirs[$i]:0:1}/"
        else
            # Empty element (leading slash or ~)
            short_path+="/"
        fi
    done

    echo "$short_path"
}
