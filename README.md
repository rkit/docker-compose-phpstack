# Docker Compose for PHP Stack 

## Soft

- PHP 5.5  
  fpm, redis, mongo, gd, imagick, xdebug, memcache, memcached, icu (55.1), opcache
- Nginx 1.9
- MySQL 5.6
- Ruby
- Git
- Nodejs + NPM
- Composer

## Install

1. Install [Docker](https://www.docker.com/) for Linux or [Docker Toolbox](https://www.docker.com/toolbox/) for OS X & Windows

2. Get the source
   ```
   git clone https://github.com/rkit/docker-compose-phpstack.git
   cd docker-compose-phpstack
   ```

3. Create and start containers

   ```
   docker-compose up
   ```

4. Open [http://192.168.99.100](http://192.168.99.100) (OS X, Windows) or [http://127.0.0.1](http://127.0.0.1) (Linux)

