[program:php-fpm]
command=php-fpm -F
user = root
numprocs=1
autostart=true
autorestart=true
startsecs=0
redirect_stderr=true
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0

echo run supervisord
/usr/bin/supervisord
exec "$@"
