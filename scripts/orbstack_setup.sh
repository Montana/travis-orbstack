#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Setting up Travis OrbStack Rails Stack with OrbStack..."

# Check if OrbStack is installed
if ! command -v orb &> /dev/null; then
    echo "❌ OrbStack is not installed. Please install it from https://orbstack.dev/"
    echo "   After installation, run this script again."
    exit 1
fi

echo "✅ OrbStack is installed"

# Check if OrbStack is running
if ! orb status &> /dev/null; then
    echo "🔄 Starting OrbStack..."
    orb start
    sleep 5
fi

echo "✅ OrbStack is running"

# Check Docker connectivity
if ! docker info &> /dev/null; then
    echo "❌ Docker is not accessible. Please check your OrbStack installation."
    exit 1
fi

echo "✅ Docker is accessible through OrbStack"

# Create OrbStack-specific directories
echo "📁 Creating OrbStack-specific directories..."
mkdir -p .orbstack/{logs,cache,data}

# Set up OrbStack environment
echo "🔧 Setting up OrbStack environment..."
export DOCKER_HOST=unix:///Users/$(whoami)/.orbstack/run/docker.sock
export ORBSTACK=true

# Build the OrbStack-optimized image
echo "🏗️  Building OrbStack-optimized Docker image..."
docker build -f Dockerfile.orbstack -t travis-orbstack:dev .

# Start services with OrbStack optimizations
echo "🚀 Starting services with OrbStack optimizations..."
docker compose -f docker-compose.orbstack.yml up -d

# Wait for services to be ready
echo "⏳ Waiting for services to be ready..."
sleep 10

# Check service health
echo "🔍 Checking service health..."
docker compose -f docker-compose.orbstack.yml ps

echo "✅ OrbStack setup complete!"
echo ""
echo "🎉 Your Travis OrbStack Rails Stack is now running with OrbStack optimizations!"
echo ""
echo "📋 Available commands:"
echo "  make orbstack-up     - Start services with OrbStack"
echo "  make orbstack-down   - Stop services"
echo "  make orbstack-logs   - View logs"
echo "  make orbstack-shell  - Open shell in app container"
echo "  make orbstack-test   - Run tests with OrbStack"
echo ""
echo "🌐 Access your application at: http://localhost:3000"
echo "📊 RabbitMQ Management: http://localhost:15673 (guest/guest)"
echo "🔍 Elasticsearch: http://localhost:9200"
