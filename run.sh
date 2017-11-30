#!/bin/bash

# Replace environment variables
envsubst < /shibboleth2.template.xml > /etc/shibboleth/shibboleth2.xml
service shibd restart

# Optional - generate shibboleth key
# We mount a pre generated cert / key in research-hub-deploy/docker-compose.front-end.yml
#shib-keygen -h research-hub.cer.auckland.ac.nz

service shibd start
httpd-foreground