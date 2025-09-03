.PHONY: dev-up dev-down test build shell ps logs orbstack-setup orbstack-up orbstack-down orbstack-test orbstack-shell orbstack-logs orbstack-ps

# Standard Docker Compose commands (for CI and general use)
dev-up:
	docker compose -f docker-compose.ci.yml up -d db redis rabbitmq elasticsearch

dev-down:
	docker compose -f docker-compose.ci.yml down -v

test:
	docker compose -f docker-compose.ci.yml up --build --abort-on-container-exit --exit-code-from app

build:
	docker build -t myapp:dev -f Dockerfile.ci .

shell:
	docker compose -f docker-compose.ci.yml run --rm app /bin/bash

ps:
	docker compose -f docker-compose.ci.yml ps

logs:
	docker compose -f docker-compose.ci.yml logs -f --tail=200

# OrbStack-specific commands (optimized for macOS development)
orbstack-setup:
	./scripts/orbstack_setup.sh

orbstack-up:
	export DOCKER_HOST=unix:///Users/$(shell whoami)/.orbstack/run/docker.sock && \
	docker compose -f docker-compose.orbstack.yml up -d

orbstack-down:
	export DOCKER_HOST=unix:///Users/$(shell whoami)/.orbstack/run/docker.sock && \
	docker compose -f docker-compose.orbstack.yml down -v

orbstack-test:
	./scripts/orbstack_test.sh

orbstack-shell:
	export DOCKER_HOST=unix:///Users/$(shell whoami)/.orbstack/run/docker.sock && \
	docker compose -f docker-compose.orbstack.yml exec app /bin/bash

orbstack-logs:
	export DOCKER_HOST=unix:///Users/$(shell whoami)/.orbstack/run/docker.sock && \
	docker compose -f docker-compose.orbstack.yml logs -f --tail=200

orbstack-ps:
	export DOCKER_HOST=unix:///Users/$(shell whoami)/.orbstack/run/docker.sock && \
	docker compose -f docker-compose.orbstack.yml ps

# Help command
help:
	@echo "Available commands:"
	@echo ""
	@echo "Standard Docker commands:"
	@echo "  dev-up      - Start services with standard Docker Compose"
	@echo "  dev-down    - Stop services"
	@echo "  test        - Run tests with standard Docker Compose"
	@echo "  build       - Build Docker image"
	@echo "  shell       - Open shell in app container"
	@echo "  ps          - Show running containers"
	@echo "  logs        - Show container logs"
	@echo ""
	@echo "OrbStack-optimized commands:"
	@echo "  orbstack-setup  - Initial OrbStack setup and configuration"
	@echo "  orbstack-up     - Start services with OrbStack optimizations"
	@echo "  orbstack-down   - Stop OrbStack services"
	@echo "  orbstack-test   - Run tests with OrbStack optimizations"
	@echo "  orbstack-shell  - Open shell in OrbStack app container"
	@echo "  orbstack-logs   - Show OrbStack container logs"
	@echo "  orbstack-ps     - Show OrbStack running containers"
	@echo ""
	@echo "Help:"
	@echo "  help        - Show this help message"
