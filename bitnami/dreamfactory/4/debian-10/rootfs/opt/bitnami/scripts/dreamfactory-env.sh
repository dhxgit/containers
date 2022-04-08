#!/bin/bash
#
# Environment configuration for dreamfactory

# The values for all environment variables will be set in the below order of precedence
# 1. Custom environment variables defined below after Bitnami defaults
# 2. Constants defined in this file (environment variables with no default), i.e. BITNAMI_ROOT_DIR
# 3. Environment variables overridden via external files using *_FILE variables (see below)
# 4. Environment variables set externally (i.e. current Bash context/Dockerfile/userdata)

# Load logging library
# shellcheck disable=SC1090,SC1091
. /opt/bitnami/scripts/liblog.sh

export BITNAMI_ROOT_DIR="/opt/bitnami"
export BITNAMI_VOLUME_DIR="/bitnami"

# Logging configuration
export MODULE="${MODULE:-dreamfactory}"
export BITNAMI_DEBUG="${BITNAMI_DEBUG:-false}"

# By setting an environment variable matching *_FILE to a file path, the prefixed environment
# variable will be overridden with the value specified in that file
dreamfactory_env_vars=(
    DREAMFACTORY_DATA_TO_PERSIST
    DREAMFACTORY_SKIP_BOOTSTRAP
    DREAMFACTORY_CREATE_ADMIN_ACCOUNT
    DREAMFACTORY_EMAIL
    DREAMFACTORY_PASSWORD
    DREAMFACTORY_FIRST_NAME
    DREAMFACTORY_LAST_NAME
    DREAMFACTORY_PHONE
    DREAMFACTORY_SMTP_HOST
    DREAMFACTORY_SMTP_PORT_NUMBER
    DREAMFACTORY_SMTP_USER
    DREAMFACTORY_SMTP_PASSWORD
    DREAMFACTORY_SMTP_PROTOCOL
    DREAMFACTORY_DATABASE_TYPE
    DREAMFACTORY_DATABASE_HOST
    DREAMFACTORY_DATABASE_PORT_NUMBER
    DREAMFACTORY_DATABASE_NAME
    DREAMFACTORY_DATABASE_USER
    DREAMFACTORY_DATABASE_PASSWORD
    DREAMFACTORY_ENABLE_MARIADB_SERVICE
    DREAMFACTORY_MARIADB_SERVICE_HOST
    DREAMFACTORY_MARIADB_SERVICE_PORT_NUMBER
    DREAMFACTORY_MARIADB_SERVICE_DATABASE_NAME
    DREAMFACTORY_MARIADB_SERVICE_DATABASE_USER
    DREAMFACTORY_MARIADB_SERVICE_DATABASE_PASSWORD
    DREAMFACTORY_ENABLE_POSTGRESQL_SERVICE
    DREAMFACTORY_POSTGRESQL_SERVICE_HOST
    DREAMFACTORY_POSTGRESQL_SERVICE_PORT_NUMBER
    DREAMFACTORY_POSTGRESQL_SERVICE_DATABASE_NAME
    DREAMFACTORY_POSTGRESQL_SERVICE_DATABASE_USER
    DREAMFACTORY_POSTGRESQL_SERVICE_DATABASE_PASSWORD
    DREAMFACTORY_ENABLE_REDIS
    DREAMFACTORY_REDIS_HOST
    DREAMFACTORY_REDIS_PORT_NUMBER
    DREAMFACTORY_REDIS_PASSWORD
    SMTP_HOST
    SMTP_PORT
    DREAMFACTORY_SMTP_PORT
    SMTP_USER
    SMTP_PASSWORD
    SMTP_PROTOCOL
    DREAMFACTORY_ENABLE_MARIADB_DATABASE
    MARIADB_HOST
    MARIADB_PORT_NUMBER
    MARIADB_USER
    MARIADB_PASSWORD
    DREAMFACTORY_ENABLE_POSTGRESQL_DATABASE
    POSTGRESQL_HOST
    POSTGRESQL_PORT_NUMBER
    POSTGRESQL_USER
    POSTGRESQL_PASSWORD
    REDIS_HOST
    REDIS_PORT_NUMBER
    REDIS_PASSWORD
)
for env_var in "${dreamfactory_env_vars[@]}"; do
    file_env_var="${env_var}_FILE"
    if [[ -n "${!file_env_var:-}" ]]; then
        if [[ -r "${!file_env_var:-}" ]]; then
            export "${env_var}=$(< "${!file_env_var}")"
            unset "${file_env_var}"
        else
            warn "Skipping export of '${env_var}'. '${!file_env_var:-}' is not readable."
        fi
    fi
done
unset dreamfactory_env_vars

# Paths
export DREAMFACTORY_BASE_DIR="${BITNAMI_ROOT_DIR}/dreamfactory"
export DREAMFACTORY_CONF_FILE="${DREAMFACTORY_BASE_DIR}/.env"

# DreamFactory persistence configuration
export DREAMFACTORY_VOLUME_DIR="${BITNAMI_VOLUME_DIR}/dreamfactory"
export DREAMFACTORY_DATA_TO_PERSIST="${DREAMFACTORY_DATA_TO_PERSIST:-.env storage}"

# DreamFactory configuration
export DREAMFACTORY_SKIP_BOOTSTRAP="${DREAMFACTORY_SKIP_BOOTSTRAP:-no}"
export DREAMFACTORY_CREATE_ADMIN_ACCOUNT="${DREAMFACTORY_CREATE_ADMIN_ACCOUNT:-no}"
export DREAMFACTORY_EMAIL="${DREAMFACTORY_EMAIL:-user@example.com}"
export DREAMFACTORY_PASSWORD="${DREAMFACTORY_PASSWORD:-}"
export DREAMFACTORY_FIRST_NAME="${DREAMFACTORY_FIRST_NAME:-UserName}"
export DREAMFACTORY_LAST_NAME="${DREAMFACTORY_LAST_NAME:-LastName}"
export DREAMFACTORY_PHONE="${DREAMFACTORY_PHONE:-+1}"

# DreamFactory SMTP credentials
DREAMFACTORY_SMTP_HOST="${DREAMFACTORY_SMTP_HOST:-"${SMTP_HOST:-}"}"
export DREAMFACTORY_SMTP_HOST="${DREAMFACTORY_SMTP_HOST:-}"
DREAMFACTORY_SMTP_PORT_NUMBER="${DREAMFACTORY_SMTP_PORT_NUMBER:-"${SMTP_PORT:-}"}"
DREAMFACTORY_SMTP_PORT_NUMBER="${DREAMFACTORY_SMTP_PORT_NUMBER:-"${DREAMFACTORY_SMTP_PORT:-}"}"
export DREAMFACTORY_SMTP_PORT_NUMBER="${DREAMFACTORY_SMTP_PORT_NUMBER:-}"
DREAMFACTORY_SMTP_USER="${DREAMFACTORY_SMTP_USER:-"${SMTP_USER:-}"}"
export DREAMFACTORY_SMTP_USER="${DREAMFACTORY_SMTP_USER:-}"
DREAMFACTORY_SMTP_PASSWORD="${DREAMFACTORY_SMTP_PASSWORD:-"${SMTP_PASSWORD:-}"}"
export DREAMFACTORY_SMTP_PASSWORD="${DREAMFACTORY_SMTP_PASSWORD:-}"
DREAMFACTORY_SMTP_PROTOCOL="${DREAMFACTORY_SMTP_PROTOCOL:-"${SMTP_PROTOCOL:-}"}"
export DREAMFACTORY_SMTP_PROTOCOL="${DREAMFACTORY_SMTP_PROTOCOL:-}"

# Database configuration
export DREAMFACTORY_DATABASE_TYPE="${DREAMFACTORY_DATABASE_TYPE:-mariadb}"
export DREAMFACTORY_DATABASE_HOST="${DREAMFACTORY_DATABASE_HOST:-mariadb}"
export DREAMFACTORY_DATABASE_PORT_NUMBER="${DREAMFACTORY_DATABASE_PORT_NUMBER:-3306}"
export DREAMFACTORY_DATABASE_NAME="${DREAMFACTORY_DATABASE_NAME:-bitnami_dreamfactory}"
export DREAMFACTORY_DATABASE_USER="${DREAMFACTORY_DATABASE_USER:-bn_dreamfactory}"
export DREAMFACTORY_DATABASE_PASSWORD="${DREAMFACTORY_DATABASE_PASSWORD:-}"

# Extra MariaDB database service configuration
DREAMFACTORY_ENABLE_MARIADB_SERVICE="${DREAMFACTORY_ENABLE_MARIADB_SERVICE:-"${DREAMFACTORY_ENABLE_MARIADB_DATABASE:-}"}"
export DREAMFACTORY_ENABLE_MARIADB_SERVICE="${DREAMFACTORY_ENABLE_MARIADB_SERVICE:-no}"
DREAMFACTORY_MARIADB_SERVICE_HOST="${DREAMFACTORY_MARIADB_SERVICE_HOST:-"${MARIADB_HOST:-}"}"
export DREAMFACTORY_MARIADB_SERVICE_HOST="${DREAMFACTORY_MARIADB_SERVICE_HOST:-mariadb}"
DREAMFACTORY_MARIADB_SERVICE_PORT_NUMBER="${DREAMFACTORY_MARIADB_SERVICE_PORT_NUMBER:-"${MARIADB_PORT_NUMBER:-}"}"
export DREAMFACTORY_MARIADB_SERVICE_PORT_NUMBER="${DREAMFACTORY_MARIADB_SERVICE_PORT_NUMBER:-3306}"
export DREAMFACTORY_MARIADB_SERVICE_DATABASE_NAME="${DREAMFACTORY_MARIADB_SERVICE_DATABASE_NAME:-df}"
DREAMFACTORY_MARIADB_SERVICE_DATABASE_USER="${DREAMFACTORY_MARIADB_SERVICE_DATABASE_USER:-"${MARIADB_USER:-}"}"
export DREAMFACTORY_MARIADB_SERVICE_DATABASE_USER="${DREAMFACTORY_MARIADB_SERVICE_DATABASE_USER:-}"
DREAMFACTORY_MARIADB_SERVICE_DATABASE_PASSWORD="${DREAMFACTORY_MARIADB_SERVICE_DATABASE_PASSWORD:-"${MARIADB_PASSWORD:-}"}"
export DREAMFACTORY_MARIADB_SERVICE_DATABASE_PASSWORD="${DREAMFACTORY_MARIADB_SERVICE_DATABASE_PASSWORD:-}"

# Extra PostgreSQL database service configuration
DREAMFACTORY_ENABLE_POSTGRESQL_SERVICE="${DREAMFACTORY_ENABLE_POSTGRESQL_SERVICE:-"${DREAMFACTORY_ENABLE_POSTGRESQL_DATABASE:-}"}"
export DREAMFACTORY_ENABLE_POSTGRESQL_SERVICE="${DREAMFACTORY_ENABLE_POSTGRESQL_SERVICE:-no}"
DREAMFACTORY_POSTGRESQL_SERVICE_HOST="${DREAMFACTORY_POSTGRESQL_SERVICE_HOST:-"${POSTGRESQL_HOST:-}"}"
export DREAMFACTORY_POSTGRESQL_SERVICE_HOST="${DREAMFACTORY_POSTGRESQL_SERVICE_HOST:-postgresql}"
DREAMFACTORY_POSTGRESQL_SERVICE_PORT_NUMBER="${DREAMFACTORY_POSTGRESQL_SERVICE_PORT_NUMBER:-"${POSTGRESQL_PORT_NUMBER:-}"}"
export DREAMFACTORY_POSTGRESQL_SERVICE_PORT_NUMBER="${DREAMFACTORY_POSTGRESQL_SERVICE_PORT_NUMBER:-5432}"
export DREAMFACTORY_POSTGRESQL_SERVICE_DATABASE_NAME="${DREAMFACTORY_POSTGRESQL_SERVICE_DATABASE_NAME:-df}"
DREAMFACTORY_POSTGRESQL_SERVICE_DATABASE_USER="${DREAMFACTORY_POSTGRESQL_SERVICE_DATABASE_USER:-"${POSTGRESQL_USER:-}"}"
export DREAMFACTORY_POSTGRESQL_SERVICE_DATABASE_USER="${DREAMFACTORY_POSTGRESQL_SERVICE_DATABASE_USER:-}"
DREAMFACTORY_POSTGRESQL_SERVICE_DATABASE_PASSWORD="${DREAMFACTORY_POSTGRESQL_SERVICE_DATABASE_PASSWORD:-"${POSTGRESQL_PASSWORD:-}"}"
export DREAMFACTORY_POSTGRESQL_SERVICE_DATABASE_PASSWORD="${DREAMFACTORY_POSTGRESQL_SERVICE_DATABASE_PASSWORD:-}"

# Redis(TM) configuration
export DREAMFACTORY_ENABLE_REDIS="${DREAMFACTORY_ENABLE_REDIS:-yes}"
DREAMFACTORY_REDIS_HOST="${DREAMFACTORY_REDIS_HOST:-"${REDIS_HOST:-}"}"
export DREAMFACTORY_REDIS_HOST="${DREAMFACTORY_REDIS_HOST:-redis}"
DREAMFACTORY_REDIS_PORT_NUMBER="${DREAMFACTORY_REDIS_PORT_NUMBER:-"${REDIS_PORT_NUMBER:-}"}"
export DREAMFACTORY_REDIS_PORT_NUMBER="${DREAMFACTORY_REDIS_PORT_NUMBER:-6379}"
DREAMFACTORY_REDIS_PASSWORD="${DREAMFACTORY_REDIS_PASSWORD:-"${REDIS_PASSWORD:-}"}"
export DREAMFACTORY_REDIS_PASSWORD="${DREAMFACTORY_REDIS_PASSWORD:-}"

# PHP configuration
export PHP_DEFAULT_MEMORY_LIMIT="256M" # only used at build time

# Custom environment variables may be defined below
