FROM ubuntu:22.04
ENV TZ=Asia/Shanghai
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && \
    apt upgrade && \
    apt install curl tar zip sudo apt-utils -y && \ 
    curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash - && \
    apt install git php8.1-cli php8.1-mbstring php8.1-simplexml php8.1-curl php8.1-gd nodejs -y && \
    ##install composer
    php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer && \
    mkdir /pareview && \
    curl -o pareviewsh-1.0.10.tar.gz https://ftp.drupal.org/files/projects/pareviewsh-1.0.10.tar.gz && tar -xzvf pareviewsh-1.0.10.tar.gz -C / && \
    ln -s /pareviewsh/pareview.sh /usr/local/bin/pareview.sh && \
    cd /pareviewsh && \
    composer install 
WORKDIR /app
