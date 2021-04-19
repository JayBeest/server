FROM debian:buster

# Install packages
RUN apt-get update && apt-get install -y \
	nginx \
	mariadb-server \
	wordpress \
	php-fpm php-mysql php-xml php-mbstring \
	openssl \
	wget \
	&& rm -rf /var/lib/apt/lists/* 

# Setup Nginx
COPY /srcs/nginx/default.conf /etc/nginx/conf.d/default.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
	&& rm /var/www/html/*.html

# Setup MariaDB
COPY /srcs/mariadb/secure_mysql.sql .
RUN service mysql start \
	&& mysql -sfu root < "secure_mysql.sql" \
	&& rm secure_mysql.sql

# Setup PHP(MyAdmin)
RUN	touch /var/www/html/info.php \
	&& echo "<?php phpinfo(); ?>" >> /var/www/html/info.php \
	&& mkdir /var/www/html/phpmyadmin \
	&& wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz \
	&& tar xvf phpMyAdmin-latest-all-languages.tar.gz \
	--strip-components=1 -C /var/www/html/phpmyadmin \
	&& rm phpMyAdmin-latest-all-languages.tar.gz
COPY ./srcs/phpmyadmin/config.inc.php /var/www/html/phpmyadmin

# Setup wordpress
RUN mkdir /var/www/html/wordpress \
	&& wget https://wordpress.org/latest.tar.gz \
	&& tar xvf latest.tar.gz --strip-components=1 -C /var/www/html/wordpress \
	&& rm latest.tar.gz
COPY /srcs/wordpress/wp-config.php /var/www/html/wordpress

# Setup mkcert
RUN wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 -O mkcert \
	&& chmod +x mkcert \
	&& ./mkcert -install && ./mkcert phpmyadmin && ./mkcert wordpress \
	&& chmod 644 *.pem

# Cleanup
RUN rm /etc/nginx/sites-enabled/default

EXPOSE 80 443

COPY /srcs/start_container.sh .
CMD ["/bin/bash", "./start_container.sh"]