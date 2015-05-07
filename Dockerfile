# Docker container for running Apache

FROM       quay.io/flippa/ubuntu:14.04
MAINTAINER Chris Corbyn <chris.corbyn@flippa.com>

RUN sudo apt-get -y update
RUN sudo apt-get -y install libapr1-dev libaprutil1-dev

RUN cd /tmp;                                                               \
    curl -LO                                                               \
    http://apache.mirror.digitalpacific.com.au/httpd/httpd-2.4.12.tar.bz2; \
    tar xvjf *.tar.bz2; rm -f *.tar.bz2;                                   \
    cd httpd-*;                                                            \
    ./configure                                                            \
      --prefix=/usr/local                                                  \
      --with-config-file-path=/www                                         \
      --enable-so                                                          \
      --enable-cgi                                                         \
      --enable-info                                                        \
      --enable-rewrite                                                     \
      --enable-deflate                                                     \
      --enable-ssl                                                         \
      --enable-mime-magic                                                  \
      --with-mpm=prefork                                                   \
      ;                                                                    \
    make && sudo make install;                                             \
    cd; rm -rf /tmp/httpd-*

ADD www /www

EXPOSE 8080
CMD    [ "apachectl", \
         "-d", "/usr/local", \
         "-f", "/www/httpd.conf", \
         "-DFOREGROUND" ]
