FROM centos:7

LABEL Maintainer="Prashant Kumar" \
      Email="prashant.2006tyagi@gmail.com"

# Version
ENV MEDIAWIKI_MAJOR_VERSION 1.24
ENV MEDIAWIKI_VERSION 1.24.0

# install dependent packages
RUN yum install -y httpd php php-mysqlnd php-gd php-xml php-fpm mariadb php-mbstring php-json; \
    yum clean all; \
    systemctl enable php-fpm; \
    /usr/sbin/php-fpm -D;

WORKDIR /var/www

# install mediawiki from tarball
RUN curl -fSL "https://releases.wikimedia.org/mediawiki/${MEDIAWIKI_MAJOR_VERSION}/mediawiki-${MEDIAWIKI_VERSION}.tar.gz" -o mediawiki.tar.gz; \
    tar -zxf mediawiki.tar.gz; \
    rm -r mediawiki.tar.gz; \
    mkdir -p /var/www/html/mediawiki; \
    mv mediawiki-${MEDIAWIKI_VERSION}/* /var/www/html/mediawiki; \
    rm -rf mediawiki-${MEDIAWIKI_VERSION};

# configure apache 
COPY conf/mediawiki.conf /etc/httpd/conf.d/


# set permission
RUN chown -R apache:apache /var/www/html/mediawiki; \
    chmod -R 777 /var/www/html/mediawiki;

EXPOSE 80

# copy entrypoint file
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["apachectl", "-e", "info", "-D", "FOREGROUND"]