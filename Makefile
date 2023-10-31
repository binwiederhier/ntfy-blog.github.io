MAKEFLAGS := --jobs=1
VERSION := $(shell git describe --tag)
COMMIT := $(shell git rev-parse --short HEAD)

.PHONY:

help:
	@echo "Typical commands (more see below):"
	@echo "  make build                      - Build web app, documentation and server/client (sloowwww)"
	@echo
	@echo "Build documentation:"
	@echo "  make docs                       - Build the documentation"
	@echo "  make docs-deps                  - Install Python dependencies (pip3 install)"
	@echo "  make docs-build                 - Actually build the documentation"
	@echo


# Building everything

clean: .PHONY
	rm -rf dist build

build: docs

update: docs-deps-update
	docker pull alpine

# Ubuntu-specific

build-deps-ubuntu:
	sudo apt-get update
	which pip3 || sudo apt-get install -y python3-pip

# Documentation

docs: docs-deps docs-build

docs-build: .PHONY
	@if ! /bin/echo -e "import sys\nif sys.version_info < (3,8):\n exit(1)" | python3; then \
	  if which python3.8; then \
	  	echo "python3.8 $(shell which mkdocs) build"; \
	    python3.8 $(shell which mkdocs) build; \
	  else \
	    echo "ERROR: Python version too low. mkdocs-material needs >= 3.8"; \
	    exit 1; \
	  fi; \
	else \
	  echo "mkdocs build"; \
	  mkdocs build; \
	fi

docs-deps: .PHONY
	pip3 install -r requirements.txt

docs-deps-update: .PHONY
	pip3 install -r requirements.txt --upgrade

