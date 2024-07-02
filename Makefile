# Variable definitions
DOCKER_COMPOSE = docker-compose
COMPOSE_FILE_DEV = docker-compose.dev.yml
COMPOSE_FILE_PROD = docker-compose.prod.yml

# Default targets
.PHONY: all build up down start stop restart logs ps exec-backend exec-frontend exec-postgres prune

# Default target
all: build up

# Build containers for development
build-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_DEV) build

# Build containers for production
build-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_PROD) build

# Start containers in detached mode for development
up-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_DEV) up -d

# Start containers in detached mode for production
up-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_PROD) up -d

# Stop and remove all running containers for development
down-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_DEV) down

# Stop and remove all running containers for production
down-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_PROD) down

# Start containers (if stopped) for development
start-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_DEV) start

# Start containers (if stopped) for production
start-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_PROD) start

# Stop all running containers for development
stop-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_DEV) stop

# Stop all running containers for production
stop-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_PROD) stop

# Restart containers for development
restart-dev: down-dev up-dev

# Restart containers for production
restart-prod: down-prod up-prod

# Show logs for development
logs-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_DEV) logs -f

# Show logs for production
logs-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_PROD) logs -f

# Show container status for development
ps-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_DEV) ps

# Show container status for production
ps-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_PROD) ps

# Access the running backend container for development
exec-backend-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_DEV) exec ${APP_NAME}-backend /bin/sh

# Access the running backend container for production
exec-backend-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_PROD) exec ${APP_NAME}-backend /bin/sh

# Access the running frontend container for development
exec-frontend-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_DEV) exec ${APP_NAME}-frontend /bin/sh

# Access the running frontend container for production
exec-frontend-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_PROD) exec ${APP_NAME}-frontend /bin/sh

# Access the running postgres container for development
exec-postgres-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_DEV) exec ${APP_NAME}-postgres /bin/sh

# Access the running postgres container for production
exec-postgres-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE_PROD) exec ${APP_NAME}-postgres /bin/sh

# Prune Docker system
prune:
	docker system prune -f
