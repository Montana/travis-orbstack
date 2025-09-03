.PHONY: dev-up dev-down test build shell ps logs

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
