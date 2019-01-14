FROM momar/caddy-php

USER 0
ADD Caddyfile /data/Caddyfile
ADD gpm-autoinstall /usr/local/bin/gpm-autoinstall
RUN apk --no-cache add curl &&\
    version=`curl https://github.com/getgrav/grav/releases/latest -Is | grep '^Location:' | sed 's|.*/||g' | tr -d '\r'` &&\
    wget "https://github.com/getgrav/grav/releases/download/$version/grav-v$version.zip" -O grav.zip &&\
    php -r '$z=new ZipArchive;$z->open("grav.zip");$z->extractTo(".");$z->close();' && rm grav.zip && chown -R 1000 /data/grav &&\
    chmod +x /data/grav/bin/*
USER 1000
WORKDIR /data/grav

CMD ["/smell-baron", "/usr/local/bin/gpm-autoinstall", \
              "---", "/usr/sbin/php-fpm7", "--allow-to-run-as-root", "--nodaemonize", "--fpm-config", "/etc/php7/php-fpm.conf", \
              "---", "/usr/local/bin/caddy", "-agree=true", "-conf=/data/Caddyfile", "-root=/data", "-log=stdout", "-email=", "-grace=1s"]
