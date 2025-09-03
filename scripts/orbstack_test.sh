#!/usr/bin/env bash
set -euo pipefail

echo "🧪 Running tests with OrbStack optimizations..."

# Set OrbStack environment
export DOCKER_HOST=unix:///Users/$(whoami)/.orbstack/run/docker.sock
export ORBSTACK=true

# Check if services are running
if ! docker compose -f docker-compose.orbstack.yml ps | grep -q "Up"; then
    echo "🚀 Starting services for testing..."
    docker compose -f docker-compose.orbstack.yml up -d
    sleep 10
fi

echo "⏳ Waiting for database..."
for i in {1..60}; do
  if docker compose -f docker-compose.orbstack.yml exec -T db pg_isready -U app -d app_test >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

echo "⏳ Waiting for Elasticsearch..."
for i in {1..60}; do
  if curl -s http://localhost:9200 >/dev/null; then
    break
  fi
  sleep 2
done

echo "🔧 Setting up test database..."
docker compose -f docker-compose.orbstack.yml exec -T app bash -c "
  export DB_HOST=db
  export DB_USERNAME=app
  export DB_PASSWORD=app
  bundle exec rails db:create RAILS_ENV=test
  bundle exec rails db:migrate RAILS_ENV=test
"

echo "🧪 Running RSpec tests..."
docker compose -f docker-compose.orbstack.yml exec -T app bundle exec rspec

echo "✅ Tests completed successfully!"
