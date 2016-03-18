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

RUN rm -f index.html \
	&& curl -L https://github.com/panique/huge/archive/{$HUGE_VERSION}.tar.gz \
		-o {$HUGE_VERSION}.tar.gz \
	&& tar -zxf {$HUGE_VERSION}.tar.gz \
	&& mv huge-${HUGE_VERSION#"v"}/* . \
	&& rm -rf huge-${HUGE_VERSION#"v"} \
	&& composer install \
	&& chmod 0777 -R public/avatars \
	&& rm -rf {$HUGE_VERSION}.tar.gz .scrutinizer.yml .travis.yml CHANGELOG.md \
		composer.json README.md travis-ci-apache _one-click-installation \
		application/_installation
