function bunrun
    docker run --rm -v (pwd)"/":/app -w /app --user (id -u):(id -g) oven/bun:1-alpine /bin/sh -c (printf "'%s' " $argv)
end

