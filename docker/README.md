# 🚀 Laravel DevOps Blog Platform (Docker Local Setup)

This project provides a **complete Dockerized development environment**
for a Laravel 9 application using custom Dockerfiles and Docker Compose.

It is designed for **local development, DevOps practice, and
container-based workflows**.

------------------------------------------------------------------------

## 📦 Project Structure (Important)

    project-root/
    │
    ├── app/                 # Laravel app code
    ├── docker/
    │   ├── docker-compose.yml
    │   ├── Dockerfile
    │   ├── Dockerfile.nginx
    │   └── nginx/
    │       └── default.conf
    │
    ├── artisan
    ├── composer.json
    ├── routes/
    ├── storage/
    └── ...

------------------------------------------------------------------------

## 🐳 Docker Architecture

This setup uses **4 containers**:

  Service      Description
  ------------ -----------------------------------
  app          PHP-FPM container running Laravel
  web          Nginx web server
  db           MySQL 8 database
  phpmyadmin   Database UI

------------------------------------------------------------------------

## ⚙️ File Explanation

### 📄 docker-compose.yml

Defines all services:

-   **app**
    -   Builds from `Dockerfile`
    -   Mounts local code for development
    -   Runs on port `9000`
-   **web**
    -   Uses Nginx (`Dockerfile.nginx`)
    -   Serves Laravel app
    -   Runs on `http://localhost:8009`
-   **db**
    -   MySQL 8 database
    -   Persistent storage via volume
-   **phpmyadmin**
    -   UI to manage database
    -   Runs on `http://localhost:8080`

------------------------------------------------------------------------

### 📄 Dockerfile (PHP-FPM)

-   Base image: `php:8.1-fpm`

-   Installs:

    -   Git, zip, curl
    -   PHP extensions (`pdo_mysql`)

-   Installs Composer

-   Copies Laravel project

-   Runs:

        composer install --no-dev --optimize-autoloader

-   Sets correct permissions

------------------------------------------------------------------------

### 📄 Dockerfile.nginx

-   Base image: `nginx:latest`

-   Removes default config

-   Adds custom config:

        docker/nginx/default.conf

------------------------------------------------------------------------

### 📄 nginx/default.conf

-   Configures Nginx to:
    -   Serve Laravel from `/public`
    -   Pass PHP requests to `app:9000`

------------------------------------------------------------------------

## ⚡ Prerequisites

Install:

-   Docker
-   Docker Compose
-   Git

------------------------------------------------------------------------

## 🚀 Setup Instructions

### 1. Go to docker directory

``` bash
cd docker
```

------------------------------------------------------------------------

### 2. Build and start containers

``` bash
docker compose up -d --build
```

------------------------------------------------------------------------

### 3. Install dependencies (if needed)

``` bash
docker exec -it laravel_app_container composer install
```

------------------------------------------------------------------------

### 4. Run migrations

``` bash
docker exec -it laravel_app_container php artisan migrate
```

------------------------------------------------------------------------

## 🌐 Access URLs

  Service       URL
  ------------- -----------------------
  Laravel App   http://localhost:8009
  phpMyAdmin    http://localhost:8080

------------------------------------------------------------------------

## 🗄️ Database Credentials

    Host: db
    Port: 3306
    Database: laravel
    Username: laravel_user
    Password: secret
    Root Password: root

------------------------------------------------------------------------

## 📂 Useful Commands

### Start

``` bash
docker compose up -d
```

### Stop

``` bash
docker compose down
```

### Rebuild

``` bash
docker compose up -d --build
```

### Enter container

``` bash
docker exec -it laravel_app_container bash
```

------------------------------------------------------------------------

## ⚠️ Common Issues

### Permission Issue

``` bash
sudo usermod -aG docker $USER
newgrp docker
```

------------------------------------------------------------------------

### Storage Permission (Laravel)

``` bash
docker exec -it laravel_app_container chmod -R 775 storage bootstrap/cache
```

------------------------------------------------------------------------

### Composer Issue

Correct command:

``` bash
docker exec -it laravel_app_container composer install
```

------------------------------------------------------------------------

## 🧠 Notes

-   Code is mounted via volume → live changes reflect instantly
-   No need to install PHP or MySQL locally
-   First build may take time

------------------------------------------------------------------------

## 🎯 Purpose

-   Learn Docker with Laravel
-   Practice DevOps workflows
-   Understand multi-container setup
-   Local development environment

------------------------------------------------------------------------

## 📄 License

MIT License