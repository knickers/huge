FROM php:5.6-apache

RUN set -x \
	&& a2enmod rewrite \
	&& apt-get update && apt-get install --no-install-recommends -y \
		libpng12-dev libjpeg-dev php5-curl php5-gd openssl curl git \
	&& rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mysqli pdo pdo_mysql zip \
	&& curl -s https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html

ENV HUGE_VERSION v3.1

RUN rm index.html \
	&& git clone https://github.com/panique/huge . \
	&& git checkout tags/$HUGE_VERSION \
	&& composer install \
	&& chmod 0777 -R public/avatars

COPY apache.conf /etc/apache2/sites-available/000-default.conf
COPY config.*.php application/config/
