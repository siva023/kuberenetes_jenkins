FROM centos:7
MAINTAINER shivagopal9515@gmail.com
RUN yum install -y httpd zip unzip
ADD https://bootstrapmade.com/content/templatefiles/PhotoFolio/PhotoFolio.zip /var/www/html/

WORKDIR /var/www/html
RUN cd /var/www/html && unzip PhotoFolio.zip && mv PhotoFolio/* . && rm -rf PhotoFolio.zip PhotoFolio
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
EXPOSE 80

