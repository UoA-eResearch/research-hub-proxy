FROM nginx:mainline

ARG         http_proxy
ARG         https_proxy

# Copies all files and maintains directory structure
COPY            / /

# Set script to executable
RUN             chmod +x run-nginx.sh
