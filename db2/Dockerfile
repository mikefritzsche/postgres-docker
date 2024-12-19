FROM postgres:16.4-alpine3.20

# Install required extensions
RUN apk update \
    && apk add --no-cache \
        postgis \
        postgis-scripts \
        postgresql-contrib

# Copy your configuration
COPY postgresql.conf /etc/postgresql/postgresql.conf

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
