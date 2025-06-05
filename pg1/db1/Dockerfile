FROM 16.9-alpine3.21

# Install required extensions
RUN apk update \
    && apk add --no-cache \
        postgis \
        postgresql-contrib \
        openssl

# Copy your configuration
COPY postgresql.conf /etc/postgresql/postgresql.conf
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]