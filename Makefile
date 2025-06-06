# Makefile for BlogDjango project
#
# Usage: make <target>
#
# Targets:
#   help         - Show this help message
#   up           - Start the development environment
#   down         - Stop and remove containers
#   build        - Build or rebuild services
#   logs         - View logs from web container
#   migrate      - Apply database migrations
#   superuser    - Create a superuser
#   backup       - Backup the database to ./backups/
#   restore      - Restore the latest backup
#   clean        - Full cleanup (down + volumes)
#   resetdb      - Reset database schema

PROJECT_NAME=blogdjango
COMPOSE=docker-compose
PYTHON=$(COMPOSE) exec web python manage.py
DB_CONTAINER=postgres_db
DB_USER=blog

.DEFAULT_GOAL := help

help:
	@echo ""
	@echo "Available commands:"
	@echo "-------------------------------------------"
	@echo "  make up           - Start the development environment"
	@echo "  make down         - Stop and remove containers"
	@echo "  make build        - Build or rebuild services"
	@echo "  make logs         - View logs from web container"
	@echo "  make migrate      - Apply database migrations"
	@echo "  make superuser    - Create a superuser"
	@echo "  make backup       - Backup the database"
	@echo "  make restore      - Restore the latest backup"
	@echo "  make clean        - Full cleanup: stop + remove volumes"
	@echo "  make resetdb      - Reset database schema"
	@echo ""

up:
	$(COMPOSE) up -d
	@echo "Application is running at http://localhost:8000"

up_console_logs:
	$(COMPOSE) up
	@echo "Application is running at http://localhost:8000"

up_firstrun:
	$(COMPOSE) build
	$(COMPOSE) up -d
	@echo "Containers built and started. Application is running at http://localhost:8000"

down:
	$(COMPOSE) down
	@echo "Containers stopped and removed."

build:
	$(COMPOSE) build
	@echo "Images built successfully."

rebuild:
	$(COMPOSE) down
	$(COMPOSE) build
	$(COMPOSE) up -d
	@echo "Containers rebuilt and started."

logs:
	$(COMPOSE) logs -f web

migrate:
	$(PYTHON) migrate --noinput
	@echo "Migrations applied."

superuser:
	$(PYTHON) create_superuser.py
	@echo "Superuser created or already exists."

backup:
	mkdir -p ./backups
	docker exec $(DB_CONTAINER) pg_dump -U $(DB_USER) -d $(PROJECT_NAME) > ./backups/backup_$(shell date +%Y%m%d_%H%M%S).sql
	@echo "Database backed up to ./backups/"

restore:
	@latest_backup=$$(ls -t ./backups/*.sql | head -n1); \
	if [ -z "$$latest_backup" ]; then \
		echo "No backups found in ./backups."; \
	else \
		echo "Restoring from $$latest_backup"; \
		docker exec -i $(DB_CONTAINER) psql -U $(DB_USER) -d $(PROJECT_NAME) -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;" && \
		cat $$latest_backup | docker exec -i $(DB_CONTAINER) psql -U $(DB_USER) -d $(PROJECT_NAME); \
	fi

clean:
	$(COMPOSE) down -v
	@echo "Project cleaned: containers, networks, and volumes removed."

resetdb:
	docker exec -i $(DB_CONTAINER) psql -U $(DB_USER) -d $(PROJECT_NAME) -c "DROP SCHEMA public CASCADE; CREATE SCHEMA public;"
	@echo "Database schema reset."
