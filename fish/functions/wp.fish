function wp
    set -x WP_CLI_MYSQL "docker exec -i mysql mysql"
    /usr/local/bin/wp $argv
end
