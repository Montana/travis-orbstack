# OrbStack Integration Guide

This project is fully integrated with [OrbStack](https://orbstack.dev/), a fast, lightweight alternative to Docker Desktop for macOS.

## 🚀 What is OrbStack?

OrbStack is a Docker Desktop alternative that provides:
- **Faster performance** on macOS
- **Lower resource usage** compared to Docker Desktop
- **Native macOS integration** with better file system performance
- **Compatible with Docker** - uses the same Docker API
- **Free for personal use**

## 📋 Prerequisites

1. **Install OrbStack**: Download from [orbstack.dev](https://orbstack.dev/)
2. **macOS**: OrbStack is macOS-only
3. **Docker knowledge**: Basic understanding of Docker and Docker Compose

## 🛠️ Setup

### 1. Install OrbStack

```bash
# Download and install from https://orbstack.dev/
# Or use Homebrew (if available)
brew install orbstack
```

### 2. Initial Project Setup

```bash
# Run the OrbStack setup script
make orbstack-setup
```

This will:
- Check if OrbStack is installed and running
- Build the OrbStack-optimized Docker image
- Start all services with OrbStack optimizations
- Set up the development environment

### 3. Verify Installation

```bash
# Check if OrbStack is running
orb status

# Check Docker connectivity
docker info

# View running containers
make orbstack-ps
```

## 🎯 OrbStack-Specific Features

### Performance Optimizations

- **tmpfs mounts** for temporary files (faster I/O)
- **Optimized memory settings** for each service
- **Shared memory configuration** for PostgreSQL
- **Volume caching** for better performance
- **Resource limits** to prevent resource exhaustion

### Development Experience

- **Hot reloading** with volume mounts
- **Faster builds** with OrbStack's optimized Docker daemon
- **Better file system performance** for macOS
- **Integrated logging** and monitoring

## 📚 Available Commands

### OrbStack Commands

```bash
# Setup and configuration
make orbstack-setup     # Initial setup with OrbStack
make help               # Show all available commands

# Service management
make orbstack-up        # Start services with OrbStack
make orbstack-down      # Stop services
make orbstack-ps        # Show running containers

# Development
make orbstack-shell     # Open shell in app container
make orbstack-logs      # View container logs
make orbstack-test      # Run tests with OrbStack

# Standard commands (work with any Docker runtime)
make dev-up             # Start services (Docker Desktop/OrbStack)
make test               # Run tests
make build              # Build Docker image
```

### Direct OrbStack Commands

```bash
# OrbStack CLI
orb status              # Check OrbStack status
orb start               # Start OrbStack
orb stop                # Stop OrbStack
orb restart             # Restart OrbStack

# Docker with OrbStack
export DOCKER_HOST=unix:///Users/$(whoami)/.orbstack/run/docker.sock
docker compose -f docker-compose.orbstack.yml up -d
```

## 🔧 Configuration Files

### OrbStack-Specific Files

- **`.orbstack`** - OrbStack configuration
- **`docker-compose.orbstack.yml`** - OrbStack-optimized services
- **`Dockerfile.orbstack`** - Development-optimized container
- **`scripts/orbstack_setup.sh`** - Setup automation
- **`scripts/orbstack_test.sh`** - Test automation

### Key Differences from Standard Setup

| Feature | Standard | OrbStack |
|---------|----------|----------|
| Docker Compose | `docker-compose.ci.yml` | `docker-compose.orbstack.yml` |
| Dockerfile | `Dockerfile.ci` | `Dockerfile.orbstack` |
| Environment | CI-focused | Development-focused |
| Volumes | Basic mounts | Optimized with tmpfs |
| Resources | Default limits | OrbStack-optimized |

## 🌐 Service URLs

When running with OrbStack:

- **Rails App**: http://localhost:3000
- **PostgreSQL**: localhost:5432
- **Redis**: localhost:6379
- **RabbitMQ Management**: http://localhost:15672 (guest/guest)
- **Elasticsearch**: http://localhost:9200

## 🐛 Troubleshooting

### Common Issues

1. **OrbStack not running**
   ```bash
   orb start
   ```

2. **Docker not accessible**
   ```bash
   export DOCKER_HOST=unix:///Users/$(whoami)/.orbstack/run/docker.sock
   ```

3. **Services not starting**
   ```bash
   make orbstack-down
   make orbstack-up
   ```

4. **Permission issues**
   ```bash
   chmod +x scripts/*.sh
   ```

### Performance Issues

- **Slow file operations**: Ensure you're using the OrbStack-optimized setup
- **High memory usage**: Check resource limits in `docker-compose.orbstack.yml`
- **Slow builds**: Use the OrbStack Dockerfile for development

## 🔄 Migration from Docker Desktop

If you're currently using Docker Desktop:

1. **Install OrbStack** alongside Docker Desktop
2. **Stop Docker Desktop** (to avoid conflicts)
3. **Run the setup**: `make orbstack-setup`
4. **Test the setup**: `make orbstack-test`

## 📊 Performance Comparison

| Metric | Docker Desktop | OrbStack |
|--------|----------------|----------|
| Startup time | ~30s | ~5s |
| Memory usage | ~2GB | ~500MB |
| File I/O | Slower | Faster |
| Build time | Standard | 20-30% faster |

## 🤝 Contributing

When contributing to this project:

1. **Use OrbStack commands** for local development
2. **Test with both** OrbStack and standard Docker
3. **Update documentation** if adding new OrbStack features
4. **Ensure compatibility** with both setups

## 📖 Additional Resources

- [OrbStack Documentation](https://orbstack.dev/docs)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Rails Docker Guide](https://docs.docker.com/samples/rails/)

## 🆘 Support

If you encounter issues:

1. Check the [troubleshooting section](#-troubleshooting)
2. Review OrbStack logs: `orb logs`
3. Check container logs: `make orbstack-logs`
4. Open an issue in the repository
