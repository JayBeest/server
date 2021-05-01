#!/bin/bash

if [ "$AUTO_INDEX" = "off" ];
then sed -i 's/autoindex on/autoindex off/g' /etc/nginx/sites-available/site
fi
service php7.3-fpm start
service mysql start
service nginx start