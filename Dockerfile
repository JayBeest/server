FROM	debian:buster
LABEL	maintainer = "jcorneli <jcorneli@student.codam.nl>"
ENV		AUTO_INDEX on

# Install packages
RUN		apt-get update && apt-get install -y \
		nginx \
		mariadb-server \
		wordpress \
		php-fpm php-mysql php-xml php-mbstring \
		openssl \
		wget \
		&& rm -rf /var/lib/apt/lists/* 

# Setup Nginx
COPY	/srcs/nginx/site.conf /etc/nginx/sites-available/site
COPY	/srcs/nginx/autoindex_off.sh .
COPY	/srcs/nginx/autoindex_on.sh .
COPY	/srcs/start_container.sh .
RUN		ln -s /etc/nginx/sites-available/site /etc/nginx/sites-enabled/site \
		&& echo "daemon off;" >> /etc/nginx/nginx.conf \
		&& chown -R www-data:www-data /var/www/html/ \
		&& chmod +x *.sh

# Setup MariaDB
COPY	/srcs/mariadb/secure_mysql.sql .
RUN		service mysql start \
		&& mysql -sfu root < "secure_mysql.sql" \
		&& service mysql stop \
		&& rm secure_mysql.sql

# Setup PHP(MyAdmin)
RUN		touch /var/www/html/info.php \
		&& echo "<?php phpinfo(); ?>" >> /var/www/html/info.php \
		&& mkdir /var/www/html/phpmyadmin \
		&& wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz \
		&& tar xvf phpMyAdmin-latest-all-languages.tar.gz \
		--strip-components=1 -C /var/www/html/phpmyadmin \
		&& rm phpMyAdmin-latest-all-languages.tar.gz
COPY	./srcs/phpmyadmin/config.inc.php /var/www/html/phpmyadmin

# Setup wordpress
RUN		mkdir /var/www/html/wordpress
COPY	/srcs/wordpress/wp-config.php /var/www/html/wordpress
RUN		wget https://wordpress.org/latest.tar.gz \
		&& tar xvf latest.tar.gz --strip-components=1 -C /var/www/html/wordpress \
		&& wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
		&& chmod +x wp-cli.phar \
		&& mv wp-cli.phar /usr/local/bin/wp \
		&& service mysql start \
		&& wp core install --url=localhost/wordpress --path=/var/www/html/wordpress --allow-root --title=Example --admin_user=admin --admin_password=secret --admin_email=info@example.com \
		&& service mysql stop \
		&& rm latest.tar.gz

# Setup mkcert
RUN		wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 -O mkcert \
		&& chmod +x mkcert \
		&& ./mkcert -install

# Cleanup
RUN		rm /var/www/html/index.nginx-debian.html /var/www/html/index.html \
		&& rm /etc/nginx/sites-enabled/default /etc/nginx/sites-available/default

EXPOSE	80 443

CMD		["/bin/bash", "./start_container.sh"]