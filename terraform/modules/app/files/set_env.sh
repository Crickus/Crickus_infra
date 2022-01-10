#!/bin/bash
set -e

DATABASE_URL="${1:-127.0.0.1:27017}"

bash -c "echo 'DATABASE_URL=${DATABASE_URL}' > ~/reddit_app_service.conf"