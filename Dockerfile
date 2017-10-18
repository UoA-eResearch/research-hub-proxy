FROM        httpd:2.4

# Required to install dependencies behind a proxy
ARG         http_proxy
ARG         https_proxy

EXPOSE      80 443

# Install dependencies
RUN         apt-get update && apt-get install -y \
		        libapache2-mod-shib2 \
		        vim \
		        curl

# Generate shibboleth key
# If app has been registered with a specific key this should be made available to the container instead
RUN         shib-keygen -h research-hub-dev.cer.auckland.ac.nz

RUN         mkdir /etc/shibboleth/metadata

COPY        shibboleth2.xml /etc/shibboleth
RUN         chmod 644 /etc/shibboleth/shibboleth2.xml

COPY        attribute-map.xml /etc/shibboleth
RUN         chmod 644 /etc/shibboleth/attribute-map.xml

RUN         service shibd restart

# Copy apache configuration files
COPY        /httpd.conf /usr/local/apache2/conf/httpd.conf
COPY        conf.d /usr/local/apache2/conf/conf.d

COPY        run.sh /run.sh
RUN         chmod +x /run.sh

CMD         ["/run.sh"]