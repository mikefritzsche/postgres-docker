FROM postgres:17-alpine

# Install build dependencies and vector extension
RUN apk add --no-cache --virtual .build-deps \
        build-base \
        git \
        postgresql-dev \
    && git clone --branch v0.6.0 https://github.com/pgvector/pgvector.git \
    && cd pgvector \
    && make \
    && make install \
    && cd .. \
    && rm -rf pgvector \
    && apk del .build-deps

# Copy configuration files
COPY postgresql.conf /etc/postgresql/postgresql.conf
COPY entrypoint.sh /docker-entrypoint-initdb.d/
COPY prepare-certs.sh /docker-entrypoint-initdb.d/

# Make scripts executable
RUN chmod +x /docker-entrypoint-initdb.d/entrypoint.sh \
    && chmod +x /docker-entrypoint-initdb.d/prepare-certs.sh

ENTRYPOINT ["/docker-entrypoint-initdb.d/entrypoint.sh"]
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]