# Makefile for Django + Vue + Dockerized project

UID := $(shell id -u)
GID := $(shell id -g)

export UID
export GID

.PHONY: all install build start dev logs clean clean-pyc clean-cache distclean

# Install Python and Node.js dependencies inside containers
install:
	docker compose run --rm --entrypoint="" web pip install -r requirements.txt
	docker compose run --rm node npm install
	sudo chown -R $(UID):$(GID) frontend/node_modules frontend/package-lock.json

# Fully remove Vue build output and node_modules
distclean:
	sudo rm -rf frontend/dist frontend/node_modules frontend/package-lock.json

# Build frontend (depends on full clean first)
build: distclean
	docker compose run --rm node npm run build
	sudo chown -R $(UID):$(GID) frontend/dist

# Stop and rebuild all containers
start:
	docker compose down --remove-orphans
	docker compose up --build

# Full dev cycle: clean → install → build → start
dev: clean install build start

# Tail Docker logs
logs:
	docker compose logs -f

# Clean everything
clean: clean-cache clean-pyc distclean

# Remove Python bytecode caches
clean-cache:
	find . -type d -name '__pycache__' -exec sudo rm -rf {} +

# Remove .pyc files
clean-pyc:
	find . -type f -name '*.pyc' -delete

