FROM debian:wheezy

MAINTAINER Igor Romanov <rkit.ru@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Performance optimization
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Dotdeb is a repository for stable and up-to-date LAMP servers
RUN echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list.d/dotdeb.list
RUN echo "deb-src http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list.d/dotdeb.list
RUN echo "deb http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list.d/dotdeb.list
RUN echo "deb-src http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list.d/dotdeb.list

# Update and Install Packages
RUN apt-get update && apt-get install -y wget && wget http://www.dotdeb.org/dotdeb.gpg -O- |apt-key add -
RUN apt-get update && apt-get install -y \
    git \
    mercurial \
    curl \
    supervisor \
    nginx \
    imagemagick \
    mysql-client \
    php5-fpm \
    php5-redis \
    php5-memcache \
    php5-memcached \
    php5-mongo \
    php5-curl \
    php5-cli \
    php5-gd \
    php5-intl \
    php5-mcrypt \
    php5-mysql \
    php5-xhprof \
    php5-imagick \
    php5-pgsql \
    php5-xdebug \
    php5-xsl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add configs
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Running PHP-FPM as root, required for volumes mounted from host
RUN sed -i.bak 's/user = www-data/user = root/' /etc/php5/fpm/pool.d/www.conf && \
    sed -i.bak 's/group = www-data/group = root/' /etc/php5/fpm/pool.d/www.conf && \
    sed -i.bak 's/--fpm-config /-R --fpm-config /' /etc/init.d/php5-fpm
    
# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/www", "/etc/nginx/sites-enabled"]

EXPOSE 80

CMD ["/usr/bin/supervisord"]
