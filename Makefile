up:
	docker compose -f docker/docker-compose.yml up -d --build

down:
	docker compose -f docker/docker-compose.yml down

bash:
	docker exec -it laravel_app_container bash

composer:
	docker exec -it laravel_app_container composer install

env:
	docker exec -it laravel_app_container cp .env.example .env

key:
	docker exec -it laravel_app_container php artisan key:generate

migrate:
	docker exec -it laravel_app_container bash -c "sleep 10 && php artisan migrate"

fresh:
	docker exec -it laravel_app_container bash -c "sleep 10 && php artisan migrate:fresh --seed"

logs:
	docker compose -f docker/docker-compose.yml logs -f

permissions:
	docker exec -it laravel_app_container chmod -R 777 storage bootstrap/cache

setup: up composer env key permissions migrate
