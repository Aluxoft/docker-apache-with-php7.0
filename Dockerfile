FROM phusion/baseimage:latest
MAINTAINER Josejulio Martínez <josejulio.martinez@aluxoft.com>

RUN apt-get update && apt-get install -y \
        php7.0 php7.0-cli php7.0-curl php7.0-gd  php7.0-json  php7.0-mysql \
	php7.0-xml  php7.0-bcmath  php7.0-imap  php7.0-mbstring  php7.0-mcrypt  php7.0-zip \
        apache2 libapache2-mod-php7.0 php7.0-cli php7.0-intl git npm

RUN a2enmod rewrite
RUN phpenmod intl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN npm install -g bower grunt-cli gulp gulp-cli
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN echo "{ \"allow_root\": true }" > ~/.bowerrc

RUN a2enmod php7.0

COPY apache2/000-default.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND
