function startphp
    set php_prefix (mise where "vfox:mise-plugins/vfox-php")
    $php_prefix/sbin/php-fpm --nodaemonize --fpm-config $php_prefix/php-fpm.conf
end
