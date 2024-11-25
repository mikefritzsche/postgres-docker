FROM postgres:15.5-alpine

# Default environment variables (override with .env)
ENV POSTGRES_DB=${POSTGRES_DB}
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

# Optional: Add custom initialization scripts
# COPY ./init.sql /docker-entrypoint-initdb.d/

EXPOSE 5432

# Optional: Custom postgres configuration
# COPY ./postgresql.conf /etc/postgresql/postgresql.conf
CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
