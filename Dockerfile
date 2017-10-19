FROM        httpd:2.4

# Required to install dependencies behind a proxy
ARG         http_proxy
ARG         https_proxy

EXPOSE      80 443

# Install dependencies
RUN         apt-get update && apt-get install -y \
		        libapache2-mod-shib2 \
		        vim \
		        curl \
                gettext-base

# Copy shibboleth files
RUN         mkdir /etc/shibboleth/metadata

COPY        shibboleth2.xml /
RUN         chmod 644 /shibboleth2.template.xml

COPY        attribute-map.xml /etc/shibboleth
RUN         chmod 644 /etc/shibboleth/attribute-map.xml

# Copy apache configuration files
COPY        /httpd.conf /usr/local/apache2/conf/httpd.conf
COPY        conf.d /usr/local/apache2/conf/conf.d

COPY        run.sh /run.sh
RUN         chmod +x /run.sh

CMD         ["/run.sh"]