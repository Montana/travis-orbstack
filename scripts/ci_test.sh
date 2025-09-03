#!/usr/bin/env bash
set -euo pipefail

echo "[ci] waiting for db..."
for i in {1..60}; do
  if PGPASSWORD=app psql -h db -U app -d app_test -c "select 1" >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

echo "[ci] waiting for elasticsearch..."
for i in {1..60}; do
  if curl -s http://elasticsearch:9200 >/dev/null; then
    break
  fi
  sleep 2
done

echo "[ci] run migrations & rspec"
bundle install --jobs=3 --retry=3

# Set database environment variables for Rails to use the container setup
export DB_HOST=db
export DB_USERNAME=app
export DB_PASSWORD=app

# Create and migrate the test database
bundle exec rails db:create RAILS_ENV=test
bundle exec rails db:migrate RAILS_ENV=test
bundle exec rspec
