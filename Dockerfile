FROM centos:8

LABEL Maintainer="Prashant" \
      Email="prashant.2006tyagi@gmail.com"

# Version
ENV MEDIAWIKI_MAJOR_VERSION 1.35
ENV MEDIAWIKI_VERSION 1.35.0

# install dependent packages
RUN yum install -y httpd php php-mysqlnd php-gd php-xml mariadb-server mariadb php-mbstring php-json; \
    yum clean all

WORKDIR /var/www

# install mediawiki from tarball
RUN curl -fSL "https://releases.wikimedia.org/mediawiki/${MEDIAWIKI_MAJOR_VERSION}/mediawiki-${MEDIAWIKI_VERSION}.tar.gz" -o mediawiki.tar.gz; \
    tar -zxf mediawiki.tar.gz; \
    rm -r mediawiki.tar.gz; \
    ln -s mediawiki-${MEDIAWIKI_VERSION}/ mediawiki; \
    chown -R apache:apache /var/www/mediawiki; 

# configure apache 
COPY apache.conf /etc/httpd/conf/httpd.conf

USER apache

# Reload apache
RUN apachectl start





