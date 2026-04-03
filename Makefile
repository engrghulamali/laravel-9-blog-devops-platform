# Makefile for Laravel Docker project (Docker Hub images)

# Compose file path
COMPOSE_FILE=docker/docker-compose.yml

# App container name
APP_CONTAINER=laravel_app_container

# Wait time for artisan commands
WAIT=10

# Wait-for-DB max seconds
WAIT_DB=20
# ------------------------
# Docker Compose commands
# ------------------------
up:
	docker compose -f $(COMPOSE_FILE) up -d --build

down:
	docker compose -f $(COMPOSE_FILE) down

logs:
	docker compose -f $(COMPOSE_FILE) logs -f

# ------------------------
# Artisan / Bash commands
# ------------------------
bash:
	docker exec -it $(APP_CONTAINER) bash

composer:
	docker exec -it $(APP_CONTAINER) composer install

env:
	docker exec -it $(APP_CONTAINER) cp .env.example .env

key:
	docker exec -it $(APP_CONTAINER) php artisan key:generate

permissions:
	docker exec -it $(APP_CONTAINER) chmod -R 777 storage bootstrap/cache

migrate-all:
	@echo "🚀 Starting containers..."
	docker compose -f $(COMPOSE_FILE) up -d
	@echo "⏳ Waiting for MySQL to be ready..."
	until docker exec -it laravel_mysql_container mysql -u laravel_user -psecret -e "SELECT 1;" > /dev/null 2>&1; do \
		sleep 5; \
	done
	@echo "✅ MySQL ready. Running migrations..."
	docker exec -it $(APP_CONTAINER) php artisan migrate
	@echo "✅ Running fresh migrations + seed..."
	docker exec -it $(APP_CONTAINER) php artisan migrate:fresh --seed
	@echo "✅ Seeding HighlightPostSeeder..."
	docker exec -it $(APP_CONTAINER) php artisan db:seed --class=HighlightPostSeeder
	@echo "🎉 All migrations & seeds completed!"

# ------------------------
# Full project setup
# ------------------------
setup: up composer env key permissions migrate-all
	@echo "✅ Laravel Docker project setup completed!"
