FROM php:8.1-apache

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
ENV SAXON_INSTALLER="libsaxon-HEC-linux-x86_64-v12.3"
ENV SAXONC_HOME=/opt/saxon

RUN apt update &&\
    apt upgrade -y &&\
    apt list | grep jdk &&\
    apt install -y curl openjdk-17-jdk-headless unzip &&\
    curl https://downloads.saxonica.com/SaxonC/HE/12/${SAXON_INSTALLER}.zip > ${SAXON_INSTALLER}.zip &&\
    unzip ${SAXON_INSTALLER}.zip &&\
    rm ${SAXON_INSTALLER}.zip
RUN mv libsaxon* /opt/saxon &&\
    ln -s /opt/saxon/libs/nix/libsaxon-hec-12.3.so /usr/lib/libsaxon-hec-12.3.so &&\
    cd /opt/saxon/Saxon.C.API/ &&\
    phpize &&\
    ./configure --enable-saxon &&\
    make &&\
    make install &&\
    echo 'extension=saxon.so' > $PHP_INI_DIR/conf.d/saxon.ini
COPY index.php /var/www/html/index.php
RUN chown www-data:www-data /var/www/html/index.php
