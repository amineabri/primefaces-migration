SHELL := /usr/bin/env bash

ATX ?= atx
GRADLE ?= ./gradlew
DOCKER_COMPOSE ?= docker compose

ASSESSMENT_NAME ?= eap-primefaces-modernization-assessment
MIGRATION_NAME ?= eap-primefaces-modernization-migration

ASSESSMENT_DIR := aws-transform/eap-primefaces-modernization/assessment
MIGRATION_DIR := aws-transform/eap-primefaces-modernization/migration
ASSESSMENT_SOURCE_DIR := $(ASSESSMENT_DIR)/definition
MIGRATION_SOURCE_DIR := $(MIGRATION_DIR)/definition
ASSESSMENT_CONFIG := $(ASSESSMENT_DIR)/config.yaml
MIGRATION_CONFIG := $(MIGRATION_DIR)/config.yaml
ASSESSMENT_CONFIG_URL := file://$(abspath $(ASSESSMENT_CONFIG))
MIGRATION_CONFIG_URL := file://$(abspath $(MIGRATION_CONFIG))
ASSESSMENT_REPORT := aws-transform/eap-primefaces-modernization/reports/assessment.md

ASSESSMENT_LIMIT ?= 30
MIGRATION_LIMIT ?= 180

ASSESSMENT_DESCRIPTION := Assess EAP 7.3 and PrimeFaces 6.2 modernization effort, cost, time, and risk
MIGRATION_DESCRIPTION := Modernize EAP 7.3 Java EE PrimeFaces app to EAP 8.1 Jakarta EE and PrimeFaces 15

.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  make build                 Build the current Gradle WAR"
	@echo "  make docker-config         Validate docker compose config"
	@echo "  make docker-up             Build and run the Docker container"
	@echo "  make assessment-publish    Publish the assessment transformer"
	@echo "  make assessment-draft      Save the assessment transformer as a draft"
	@echo "  make assessment-run        Run assessment with ASSESSMENT_LIMIT=$(ASSESSMENT_LIMIT)"
	@echo "  make assessment-validate   Validate $(ASSESSMENT_REPORT)"
	@echo "  make migration-publish     Publish the migration transformer"
	@echo "  make migration-draft       Save the migration transformer as a draft"
	@echo "  make migration-run         Run migration with MIGRATION_LIMIT=$(MIGRATION_LIMIT)"
	@echo "  make migration-validate    Validate the modernized app"
	@echo "  make atx-status            Check local ATX command availability"

.PHONY: build
build:
	@$(GRADLE) clean build

.PHONY: docker-config
docker-config:
	@$(DOCKER_COMPOSE) config

.PHONY: docker-up
docker-up: build
	@$(DOCKER_COMPOSE) up --build

.PHONY: atx-status
atx-status:
	@$(ATX) --version
	@$(ATX) custom def publish --help >/dev/null
	@$(ATX) custom def exec --help >/dev/null
	@echo "ATX custom publish/exec commands are available."

.PHONY: assessment-publish
assessment-publish:
	@$(ATX) custom def publish \
		--transformation-name "$(ASSESSMENT_NAME)" \
		--source-directory "$(ASSESSMENT_SOURCE_DIR)" \
		--description "$(ASSESSMENT_DESCRIPTION)"

.PHONY: assessment-draft
assessment-draft:
	@$(ATX) custom def save-draft \
		--transformation-name "$(ASSESSMENT_NAME)" \
		--source-directory "$(ASSESSMENT_SOURCE_DIR)" \
		--description "$(ASSESSMENT_DESCRIPTION)"

.PHONY: assessment-run
assessment-run:
	@$(ATX) custom def exec \
		--code-repository-path . \
		--transformation-name "$(ASSESSMENT_NAME)" \
		--configuration "$(ASSESSMENT_CONFIG_URL)" \
		--limit "$(ASSESSMENT_LIMIT)"

.PHONY: assessment-validate
assessment-validate:
	@bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-assessment.sh

.PHONY: migration-publish
migration-publish:
	@$(ATX) custom def publish \
		--transformation-name "$(MIGRATION_NAME)" \
		--source-directory "$(MIGRATION_SOURCE_DIR)" \
		--description "$(MIGRATION_DESCRIPTION)"

.PHONY: migration-draft
migration-draft:
	@$(ATX) custom def save-draft \
		--transformation-name "$(MIGRATION_NAME)" \
		--source-directory "$(MIGRATION_SOURCE_DIR)" \
		--description "$(MIGRATION_DESCRIPTION)"

.PHONY: migration-run
migration-run:
	@$(ATX) custom def exec \
		--code-repository-path . \
		--transformation-name "$(MIGRATION_NAME)" \
		--configuration "$(MIGRATION_CONFIG_URL)" \
		--limit "$(MIGRATION_LIMIT)"

.PHONY: migration-validate
migration-validate:
	@$(GRADLE) clean build
	@bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-modernized.sh
	@$(DOCKER_COMPOSE) config
