#!/bin/bash
set -e

# Run the prepare-certs script if it exists
if [ -f "/docker-entrypoint-initdb.d/prepare-certs.sh" ]; then
    /docker-entrypoint-initdb.d/prepare-certs.sh
fi

# Function to enable extensions
enable_extensions() {
    local db=$1
    echo "Enabling extensions for database: $db"
    
    # Try to create vector extension
    if psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$db" -c "CREATE EXTENSION IF NOT EXISTS vector;" 2>/dev/null; then
        echo "Successfully enabled vector extension in $db"
    else
        echo "Warning: Failed to create vector extension in $db. Retrying with additional steps..."
        # Additional diagnostic steps
        psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$db" <<-EOSQL
            SELECT * FROM pg_available_extensions WHERE name = 'vector';
            SELECT current_setting('shared_preload_libraries');
EOSQL
    fi

    # Create uuid-ossp extension
    if psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$db" -c "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\";" 2>/dev/null; then
        echo "Successfully enabled uuid-ossp extension in $db"
    else
        echo "Warning: Failed to create uuid-ossp extension in $db"
    fi
}

# Enable extensions for the default database
enable_extensions "$POSTGRES_DB"

# Execute the main PostgreSQL entrypoint script
exec docker-entrypoint.sh "$@"