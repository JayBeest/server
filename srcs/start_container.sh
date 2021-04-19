#!/bin/bash

chown -R www-data /var/www/html/*
service php7.3-fpm start
service mysql start
service nginx start