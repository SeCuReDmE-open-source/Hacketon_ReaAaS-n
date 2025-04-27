# Define variables
PYTHON = python3
PIP = pip3
DOCKER_COMPOSE = docker-compose

# Define targets
.PHONY: all install build run test clean setup train-model install_mindsdb install_handler dev precommit check build_docker run_docker test_docker neuuro_train neuuro_run neuuro_test submodules run_servers install_neutrosophic build_neutrosophic run_neutrosophic setup_airbyte run_airbyte

# Default target
all: submodules install build run

# Install dependencies
install:
	pip install -e .
	$(PIP) install -r requirements.txt

install_mindsdb:
	pip install -e .
	pip install -r requirements/requirements-dev.txt
	pre-commit install

install_handler:
	@if [[ -n "$(HANDLER_NAME)" ]]; then\
		pip install -e .[$(HANDLER_NAME)];\
	else\
		echo 'Please set $$HANDLER_NAME to the handler to install.';\
	fi	

install_neutrosophic:
	$(PIP) install -r neutrosophic-quantum-ffed-enhancement/requirements.txt

# Development targets
dev: install precommit

precommit:
	pre-commit install
	pre-commit run --files $$(git diff --cached --name-only)

check:
	python tests/scripts/check_requirements.py
	python tests/scripts/check_version.py
	python tests/scripts/check_print_statements.py

# Build Docker images
build: submodules
	$(DOCKER_COMPOSE) build

build_neutrosophic:
	docker build -t neutrosophic-quantum-ffed-enhancement -f neutrosophic-quantum-ffed-enhancement/Dockerfile neutrosophic-quantum-ffed-enhancement

# Run the services
run: submodules
	$(DOCKER_COMPOSE) up

run_mindsdb:
	python -m mindsdb

run_neutrosophic:
	docker run -d --name neutrosophic-quantum-ffed-enhancement -p 8084:8084 neutrosophic-quantum-ffed-enhancement

# Run tests
test:
	$(PYTHON) -m unittest discover -s tests

# Docker targets
build_docker:
	docker buildx build -t neutrosophic-mindsdb --load \
		-f src/modules/NeutrosophicDataProcessing/neutrosophic.Dockerfile .

run_docker: build_docker
	docker compose up -d

test_docker:
	docker compose run test

# NeuUuR-o specific targets
neuuro_train:
	python src/modules/NeutrosophicDataProcessing/train_neuuro.py

neuuro_run:
	docker compose up neuuro_actuator

neuuro_test:
	python -m pytest tests/neuuro/

# Clean up
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	rm -rf build/ dist/ *.egg-info/
	$(DOCKER_COMPOSE) down
	rm -rf __pycache__
	rm -rf .pytest_cache
	rm -rf .mypy_cache
	rm -rf .coverage
	rm -rf coverage.xml
	rm -rf htmlcov

setup:
	# ...existing setup commands...
	bash setup-commands.sh

train-model:
	python src/modules/NeutrosophicDataProcessing/data_filter_adapter.py

# Initialize and update submodules
submodules:
	git submodule update --init --recursive

# Run the subrepo server
run_servers:
	$(DOCKER_COMPOSE) up servers

# Airbyte specific targets
setup_airbyte:
	python src/modules/NeutrosophicDataProcessing/airbyte_pipeline.py

run_airbyte:
	docker-compose up airbyte-server airbyte-webapp airbyte-db
