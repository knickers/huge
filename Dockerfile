FROM php:5.6-apache

# install the PHP extensions we need
RUN apt-get update && apt-get install -y \
#		libpng12-dev libjpeg-dev \
		curl php5-curl openssl php5-gd git \
	&& rm -rf /var/lib/apt/lists/* \
#	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
#	&& docker-php-ext-install gd

RUN docker-php-ext-install mysqli

RUN echo <<EOF
<VirtualHost *:80>
	DocumentRoot "/var/www/html/public"
	<Directory "/var/www/html/public">
		AllowOverride All
		Require all granted
	</Directory>
</VirtualHost>
EOF > /etc/apache2/sites-available/000-default.conf \
	&& a2enmod rewrite

WORKDIR /var/www/html

ENV HUGE_VERSION 3.1

RUN git clone https://github.com/panique/huge.git . \
	&& git checkout tags/$HUGE_VERSION

RUN curl -s https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer
	&& composer install --dev \
	&& chmod 0777 -R public/avatars \
	&& rm index.html

CMD ["apache2-forground"]
