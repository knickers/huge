FROM php:5.6-apache

RUN a2enmod rewrite

RUN apt-get update && apt-get install --no-install-recommends -y \
		libpng12-dev libjpeg-dev php5-curl php5-gd openssl \
	&& rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd pdo pdo_mysql zip

RUN curl -s https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html

ENV HUGE_VERSION v3.1

RUN rm index.html \
	&& apt-get update && apt-get install --no-install-recommends -y git \
	&& git clone https://github.com/panique/huge . \
	&& git checkout tags/$HUGE_VERSION \
	&& apt-get purge --auto-remove -y git \
	&& composer install \
	&& chmod 0777 -R public/avatars \
	&& rm -rf /var/lib/apt/lists/* \
		.htaccess .scrutinizer.yml .travis.yml composer.json travis-ci-apache
