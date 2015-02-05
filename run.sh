#!/bin/bash

# Prepare log output
touch /var/log/nginx/access.log \
      /var/log/nginx/error.log  

# Start PHP and Nginx
service php5-fpm start
/usr/sbin/nginx