Docker Container for development
========

#### Include:

- nginx
- php 5.5
- php-fpm
- php-redis
- php-mongo
- php-memcache
- php-memcached
- php-xhprof
- php-xdebug

## Install

1. Install [Docker](https://www.docker.com/) for Linux or [Boot2Docker](http://boot2docker.io/) for OS X & Windows

2. Pull an image from registry to local machine
   
   ```   
   docker pull rkit/docker-nginx-php
   ```

3. Run from your working directory 

   ```   
   docker run --name c-app -d -p 80:80 -v `pwd`:/app rkit/docker-nginx-php
   ```

4. Open [http://192.168.59.103](http://192.168.59.103) (OS X, Windows) or [http://127.0.0.1](http://127.0.0.1) (Linux)

## Run with MySQL

```
docker run --name c-mysql-data -v /var/lib/mysql busybox
docker run --name c-mysql -d --volumes-from c-mysql-data -p 3306:3306 -e MYSQL_ROOT_PASSWORD=fghfgh mysql
docker run --name c-app --link c-mysql:mysql -d -p 8888:80 -v `pwd`:/app rkit/docker-nginx-php
```

