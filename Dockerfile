FROM nginx:mainline

# Copies all files and maintains directory structure
COPY            / /

# Set script to executable
RUN             chmod +x set-nginx-env.sh
