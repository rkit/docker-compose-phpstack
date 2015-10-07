# Docker for web development stack

## Soft

- Nginx 1.9
- PHP 5.5.25 (fpm, redis, mongo, gd, imagick, xdebug, memcache, memcached, icu-55.1, opcache)
- MySQL 5.6
- Ruby
- Git
- Nodejs (npm)
- Composer

## Install

1. Install [Docker](https://www.docker.com/) for Linux or [Docker Toolbox](https://www.docker.com/toolbox/) for OS X & Windows

2. Get the source
   ```
   git clone https://github.com/rkit/docker-phpstack.git
   cd docker-phpstack
   ```

3. Create and start containers

   ```
   docker-compose -p server up
   ```

4. Open [http://192.168.99.100](http://192.168.99.100) (OS X, Windows) or [http://127.0.0.1](http://127.0.0.1) (Linux)

## Setting up the environment

- Virtual hosts settings in **docker-compose.yml**
- The required settings can be specified in the configuration files (see in **docker-compose.yml**)
- Additional service (e.g. redis/mongo/etc) can be specified in **docker-compose.yml**
