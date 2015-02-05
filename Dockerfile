FROM debian:wheezy
MAINTAINER Igor Romanov <rkit.ru@gmail.com>

# Prepare Debian environment
ENV DEBIAN_FRONTEND noninteractive

# Performance optimization - see https://gist.github.com/jpetazzo/6127116
# this forces dpkg not to call sync() after package extraction and speeds up install
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup

# We don't need and apt cache in a container
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Dotdeb is a repository containing packages to turn your Debian boxes into powerful, 
# stable and up-to-date LAMP servers
RUN echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list.d/dotdeb.list
RUN echo "deb-src http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list.d/dotdeb.list
RUN echo "deb http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list.d/dotdeb.list
RUN echo "deb-src http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list.d/dotdeb.list

# Update and install system base packages

RUN apt-get update && \
    apt-get install -y wget && \
    wget http://www.dotdeb.org/dotdeb.gpg -O- |apt-key add -

RUN apt-get update && \
    apt-get install -y \
        git \
        mercurial \
        curl \
        nginx \
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
        php5-pgsql \
        php5-xdebug \
        php5-xsl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    
# Install Node & NPM
RUN curl -sL https://deb.nodesource.com/setup | bash - && apt-get -y install nodejs

# Initialize application
WORKDIR /app

# Install composer && global asset plugin
ENV COMPOSER_HOME /root/.composer
ENV PATH /root/.composer/vendor/bin:$PATH
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    /usr/local/bin/composer global require "fxp/composer-asset-plugin:1.0.0"

# Prepare PHP & Nginx
ADD default /etc/nginx/sites-available/default
ADD nginx.conf /etc/nginx/conf.d/
ADD php.ini /etc/php5/fpm/conf.d/php.ini

RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \
    echo "cgi.fix_pathinfo = 0;" >> /etc/php5/fpm/php.ini && \
    # Running PHP-FPM as root, required for volumes mounted from host
    sed -i.bak 's/user = www-data/user = root/' /etc/php5/fpm/pool.d/www.conf && \
    sed -i.bak 's/group = www-data/group = root/' /etc/php5/fpm/pool.d/www.conf && \
    sed -i.bak 's/--fpm-config /-R --fpm-config /' /etc/init.d/php5-fpm
    
# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

ADD run.sh /root/run.sh
RUN chmod 700 /root/run.sh

CMD ["/root/run.sh"]

EXPOSE 80