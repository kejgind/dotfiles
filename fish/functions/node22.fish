function node22
    docker run --rm -v (pwd)"/":/app -w /app --user (id -u):(id -g) node:22-alpine /bin/sh -c (printf "'%s' " $argv)
end

