FROM tomcat:8.5.78
MAINTAINER roja<krojakumari99@gmail.com>
COPY target/money-transfer.war /usr/local/tomcat/webapps/
