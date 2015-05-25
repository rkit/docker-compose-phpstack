FROM php:5.5.25-fpm

# --- PHP --- #

RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    zlib1g-dev \
    libicu-dev \
    libssl-dev \
    g++ \
    libmemcached-dev \
    wget

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-install gd && \
    docker-php-ext-install intl && \
    docker-php-ext-install opcache && \
    docker-php-ext-install zip && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install mbstring

RUN pecl channel-update pecl.php.net && \
    pecl install intl && \
    pecl install redis && \
    pecl install mongo && \
    pecl install memcache && \
    pecl install memcached

RUN echo "extension=mongo.so" > /usr/local/etc/php/conf.d/ext-mongo.ini && \
    echo "extension=redis.so" > /usr/local/etc/php/conf.d/ext-redis.ini && \
    echo "extension=memcache.so" > /usr/local/etc/php/conf.d/ext-memcache.ini && \
    echo "extension=memcached.so" > /usr/local/etc/php/conf.d/ext-memcached.ini

# --- NGINX --- #

RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    ca-certificates \
    nginx=1.9.0-1~jessie \
    supervisor && \
    rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

# --- PREPARE --- #

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

VOLUME ["/var/www", "/etc/nginx/conf.d"]

EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
