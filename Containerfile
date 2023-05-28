FROM ubi9/ubi
MAINTAINER Mohamed Karam
LABEL description="A custom Apache container based on UBI 9"
RUN yum install -y httpd && \
yum clean all
RUN echo "Hello from Karam's Containerfile" > /var/www/html/index.html
RUN echo "ServerName 127.0.0.1" >> /etc/httpd/conf/httpd.conf
EXPOSE 80
CMD ["httpd", "-D", "FOREGROUND"]
