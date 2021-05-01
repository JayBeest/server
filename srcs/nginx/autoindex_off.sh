#!/bin/bash

sed -i 's/autoindex on/autoindex off/g' /etc/nginx/sites-available/site
service nginx reload