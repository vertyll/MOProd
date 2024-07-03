# Variable definitions
DOCKER_COMPOSE = docker-compose
COMPOSE_FILE = docker-compose.yml
COMPOSE_FILE_OVERRIDE = docker-compose.override.yml

# Default targets
.PHONY: all build-dev build-prod up-dev up-prod down-dev down-prod start-dev start-prod stop-dev stop-prod restart-dev restart-prod logs-dev logs-prod ps-dev ps-prod exec-backend-dev exec-backend-prod exec-frontend-dev exec-frontend-prod exec-postgres-dev exec-postgres-prod prune

# Default target
all: build-dev up-dev

# Build containers for development
build-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) -f $(COMPOSE_FILE_OVERRIDE) build

# Build containers for production
build-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) build

# Start containers in detached mode for development
up-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) -f $(COMPOSE_FILE_OVERRIDE) up -d

# Start containers in detached mode for production
up-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) up -d

# Stop and remove all running containers for development
down-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) -f $(COMPOSE_FILE_OVERRIDE) down

# Stop and remove all running containers for production
down-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) down

# Start containers (if stopped) for development
start-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) -f $(COMPOSE_FILE_OVERRIDE) start

# Start containers (if stopped) for production
start-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) start

# Stop all running containers for development
stop-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) -f $(COMPOSE_FILE_OVERRIDE) stop

# Stop all running containers for production
stop-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) stop

# Restart containers for development
restart-dev: down-dev up-dev

# Restart containers for production
restart-prod: down-prod up-prod

# Show logs for development
logs-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) -f $(COMPOSE_FILE_OVERRIDE) logs -f

# Show logs for production
logs-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) logs -f

# Show container status for development
ps-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) -f $(COMPOSE_FILE_OVERRIDE) ps

# Show container status for production
ps-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) ps

# Access the running backend container for development
exec-backend-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) -f $(COMPOSE_FILE_OVERRIDE) exec ${APP_NAME}-backend /bin/sh

# Access the running backend container for production
exec-backend-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) exec ${APP_NAME}-backend /bin/sh

# Access the running frontend container for development
exec-frontend-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) -f $(COMPOSE_FILE_OVERRIDE) exec ${APP_NAME}-frontend /bin/sh

# Access the running frontend container for production
exec-frontend-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) exec ${APP_NAME}-frontend /bin/sh

# Access the running postgres container for development
exec-postgres-dev:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) -f $(COMPOSE_FILE_OVERRIDE) exec ${APP_NAME}-postgres /bin/sh

# Access the running postgres container for production
exec-postgres-prod:
	$(DOCKER_COMPOSE) -f $(COMPOSE_FILE) exec ${APP_NAME}-postgres /bin/sh

# Prune Docker system
system-prune:
	docker system prune -f

# Prune Docker volumes
volume-prune:
	docker volume prune -f

# Prune Docker builder cache
builder-prune:
	docker builder prune -f

# Prune Docker images
image-prune:
	docker image prune -f
