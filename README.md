Docker Container for development: Nginx + PHP-FMP (5.5)
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

1. Install Boot2Docker http://boot2docker.io/ for OS X & Windows

2. Run
   
   ```   
   docker build -t dev-nginx-php .
   docker run --name c-app -d -p 8888:80 -v `pwd`:/app dev-nginx-php
   ```

3. Open [http://192.168.59.103:8888](http://192.168.59.103:8888) (OS X, Windows) or [http://127.0.0.1:8888](http://127.0.0.1:8888) (Linux)

## Run with MySQL

```
docker run --name c-mysql-data -v /var/lib/mysql busybox
docker run --name c-mysql -d --volumes-from c-mysql-data -p 3306:3306 -e MYSQL_ROOT_PASSWORD=fghfgh mysql
docker run --name c-app --link c-mysql:mysql -d -p 8888:80 -v `pwd`:/app dev-nginx-php
```

