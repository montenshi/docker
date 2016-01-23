FROM ubuntu:14.04

# Install PHP and supporting packages
RUN apt-get update -y
RUN apt-get install -y python-software-properties software-properties-common apt-transport-https
RUN apt-key update
RUN apt-get update -y

RUN apt-get install -y php5-common libapache2-mod-php5 php5-cli \
    bzr git mercurial build-essential \
    curl

# Install Composer
RUN cd /tmp && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

# Customize Apache
COPY apache-sites-default /etc/apache2/sites-available/default
COPY apache-envvars /etc/apache2/envvars

# Install timecop
RUN apt-get install -y php5-dev && \
    git clone https://github.com/hnw/php-timecop.git && \
    cd php-timecop && \
    phpize && \
    ./configure && \
    make && \
    make install && \
    sed -i '$aextension=timecop.so' /etc/php5/apache2/php.ini


