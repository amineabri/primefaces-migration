SHELL := /usr/bin/env bash

ATX ?= atx
GRADLE ?= ./gradlew
DOCKER_COMPOSE ?= docker compose

ASSESSMENT_DIR := aws-transform/eap-primefaces-modernization/assessment
MIGRATION_DIR := aws-transform/eap-primefaces-modernization/migration
REPORT_DIR := aws-transform/eap-primefaces-modernization/reports

ASSESSMENT_NAME ?= eap-primefaces-modernization-assessment
ASSESSMENT_CONFIG := $(ASSESSMENT_DIR)/config.yaml
ASSESSMENT_CONFIG_URL := file://$(abspath $(ASSESSMENT_CONFIG))
ASSESSMENT_REPORT := $(REPORT_DIR)/assessment.md
ASSESSMENT_LIMIT ?= 60
ASSESSMENT_DESCRIPTION := Estimate all PrimeFaces major-line migration stages and final EAP Jakarta cutover

STAGES := pf7 pf8 pf10 pf11 pf12 pf13 pf14 pf15

pf7_DIR := 01-primefaces-7
pf7_LABEL := PrimeFaces 6.2.30 -> 7.0
pf7_ASSESSMENT_NAME := eap-primefaces-assessment-pf7
pf7_MIGRATION_NAME := eap-primefaces-modernization-pf7
pf7_DESCRIPTION := PrimeFaces 6.2.30 to 7.0
pf7_REPORT := $(REPORT_DIR)/01-primefaces-7-assessment.md
pf7_ASSESSMENT_LIMIT ?= 30
pf7_LIMIT ?= 45

pf8_DIR := 02-primefaces-8
pf8_LABEL := PrimeFaces 7.0 -> 8.0
pf8_ASSESSMENT_NAME := eap-primefaces-assessment-pf8
pf8_MIGRATION_NAME := eap-primefaces-modernization-pf8
pf8_DESCRIPTION := PrimeFaces 7.0 to 8.0
pf8_REPORT := $(REPORT_DIR)/02-primefaces-8-assessment.md
pf8_ASSESSMENT_LIMIT ?= 30
pf8_LIMIT ?= 45

pf10_DIR := 03-primefaces-10
pf10_LABEL := PrimeFaces 8.0 -> 10.0.0
pf10_ASSESSMENT_NAME := eap-primefaces-assessment-pf10
pf10_MIGRATION_NAME := eap-primefaces-modernization-pf10
pf10_DESCRIPTION := PrimeFaces 8.0 to 10.0.0
pf10_REPORT := $(REPORT_DIR)/03-primefaces-10-assessment.md
pf10_ASSESSMENT_LIMIT ?= 30
pf10_LIMIT ?= 60

pf11_DIR := 04-primefaces-11
pf11_LABEL := PrimeFaces 10.0.0 -> 11.0.0
pf11_ASSESSMENT_NAME := eap-primefaces-assessment-pf11
pf11_MIGRATION_NAME := eap-primefaces-modernization-pf11
pf11_DESCRIPTION := PrimeFaces 10.0.0 to 11.0.0
pf11_REPORT := $(REPORT_DIR)/04-primefaces-11-assessment.md
pf11_ASSESSMENT_LIMIT ?= 30
pf11_LIMIT ?= 60

pf12_DIR := 05-primefaces-12
pf12_LABEL := PrimeFaces 11.0.0 -> 12.0.0
pf12_ASSESSMENT_NAME := eap-primefaces-assessment-pf12
pf12_MIGRATION_NAME := eap-primefaces-modernization-pf12
pf12_DESCRIPTION := PrimeFaces 11.0.0 to 12.0.0
pf12_REPORT := $(REPORT_DIR)/05-primefaces-12-assessment.md
pf12_ASSESSMENT_LIMIT ?= 30
pf12_LIMIT ?= 60

pf13_DIR := 06-primefaces-13
pf13_LABEL := PrimeFaces 12.0.0 -> 13.0.0
pf13_ASSESSMENT_NAME := eap-primefaces-assessment-pf13
pf13_MIGRATION_NAME := eap-primefaces-modernization-pf13
pf13_DESCRIPTION := PrimeFaces 12.0.0 to 13.0.0
pf13_REPORT := $(REPORT_DIR)/06-primefaces-13-assessment.md
pf13_ASSESSMENT_LIMIT ?= 30
pf13_LIMIT ?= 60

pf14_DIR := 07-primefaces-14
pf14_LABEL := PrimeFaces 13.0.0 -> 14.0.0
pf14_ASSESSMENT_NAME := eap-primefaces-assessment-pf14
pf14_MIGRATION_NAME := eap-primefaces-modernization-pf14
pf14_DESCRIPTION := PrimeFaces 13.0.0 to 14.0.0
pf14_REPORT := $(REPORT_DIR)/07-primefaces-14-assessment.md
pf14_ASSESSMENT_LIMIT ?= 30
pf14_LIMIT ?= 60

pf15_DIR := 08-primefaces-15-jakarta
pf15_LABEL := PrimeFaces 14.0.0 -> 15.0.16 Jakarta + EAP 8.1
pf15_ASSESSMENT_NAME := eap-primefaces-assessment-pf15
pf15_MIGRATION_NAME := eap-primefaces-modernization-pf15
pf15_DESCRIPTION := PrimeFaces 14.0.0 to 15.0.16 Jakarta plus JBoss EAP 8.1
pf15_REPORT := $(REPORT_DIR)/08-primefaces-15-jakarta-assessment.md
pf15_ASSESSMENT_LIMIT ?= 45
pf15_LIMIT ?= 180

.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  make build                    Build the current Gradle WAR"
	@echo "  make docker-config            Validate docker compose config"
	@echo "  make docker-up                Build and run the Docker container"
	@echo "  make assessment-publish       Publish consolidated staged assessment"
	@echo "  make assessment-run           Run consolidated staged assessment"
	@echo "  make assessment-validate      Validate consolidated assessment report"
	@echo "  make assessments-publish      Publish all per-version assessment transformers"
	@echo "  make assessments-run          Run all per-version assessments"
	@echo "  make assessments-validate     Validate all per-version assessment reports"
	@echo "  make staged-publish           Publish all per-version migration transformers"
	@echo "  make staged-run               Run all migrations in order; QA is recommended between individual stages"
	@echo "  make <stage>-assessment-run   Run one estimate; stages: $(STAGES)"
	@echo "  make <stage>-run              Run one migration; stages: $(STAGES)"
	@echo "  make atx-status               Check local ATX command availability"

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
		--source-directory "$(ASSESSMENT_DIR)/definition" \
		--description "$(ASSESSMENT_DESCRIPTION)"

.PHONY: assessment-draft
assessment-draft:
	@$(ATX) custom def save-draft \
		--transformation-name "$(ASSESSMENT_NAME)" \
		--source-directory "$(ASSESSMENT_DIR)/definition" \
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
	@bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-assessment.sh "$(ASSESSMENT_REPORT)"

define stage_targets
.PHONY: $(1)-assessment-publish
$(1)-assessment-publish:
	@$$(ATX) custom def publish \
		--transformation-name "$$($(1)_ASSESSMENT_NAME)" \
		--source-directory "$$(ASSESSMENT_DIR)/$$($(1)_DIR)/definition" \
		--description "Estimate $$($(1)_DESCRIPTION)"

.PHONY: $(1)-assessment-draft
$(1)-assessment-draft:
	@$$(ATX) custom def save-draft \
		--transformation-name "$$($(1)_ASSESSMENT_NAME)" \
		--source-directory "$$(ASSESSMENT_DIR)/$$($(1)_DIR)/definition" \
		--description "Estimate $$($(1)_DESCRIPTION)"

.PHONY: $(1)-assessment-run
$(1)-assessment-run:
	@$$(ATX) custom def exec \
		--code-repository-path . \
		--transformation-name "$$($(1)_ASSESSMENT_NAME)" \
		--configuration "file://$$(abspath $$(ASSESSMENT_DIR)/$$($(1)_DIR)/config.yaml)" \
		--limit "$$($(1)_ASSESSMENT_LIMIT)"

.PHONY: $(1)-assessment-validate
$(1)-assessment-validate:
	@bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-assessment.sh "$$($(1)_REPORT)"

.PHONY: $(1)-publish
$(1)-publish:
	@$$(ATX) custom def publish \
		--transformation-name "$$($(1)_MIGRATION_NAME)" \
		--source-directory "$$(MIGRATION_DIR)/$$($(1)_DIR)/definition" \
		--description "Migrate $$($(1)_DESCRIPTION)"

.PHONY: $(1)-draft
$(1)-draft:
	@$$(ATX) custom def save-draft \
		--transformation-name "$$($(1)_MIGRATION_NAME)" \
		--source-directory "$$(MIGRATION_DIR)/$$($(1)_DIR)/definition" \
		--description "Migrate $$($(1)_DESCRIPTION)"

.PHONY: $(1)-run
$(1)-run:
	@$$(ATX) custom def exec \
		--code-repository-path . \
		--transformation-name "$$($(1)_MIGRATION_NAME)" \
		--configuration "file://$$(abspath $$(MIGRATION_DIR)/$$($(1)_DIR)/config.yaml)" \
		--limit "$$($(1)_LIMIT)"
endef

$(foreach stage,$(STAGES),$(eval $(call stage_targets,$(stage))))

.PHONY: assessments-publish
assessments-publish: $(addsuffix -assessment-publish,$(STAGES))

.PHONY: assessments-draft
assessments-draft: $(addsuffix -assessment-draft,$(STAGES))

.PHONY: assessments-run
assessments-run: $(addsuffix -assessment-run,$(STAGES))

.PHONY: assessments-validate
assessments-validate: $(addsuffix -assessment-validate,$(STAGES))

.PHONY: staged-publish
staged-publish: $(addsuffix -publish,$(STAGES))

.PHONY: staged-draft
staged-draft: $(addsuffix -draft,$(STAGES))

.PHONY: staged-run
staged-run: $(addsuffix -run,$(STAGES))

.PHONY: migration-publish
migration-publish:
	@echo "Use staged migrations instead: make staged-publish"

.PHONY: migration-run
migration-run:
	@echo "Use one stage at a time for QA: make pf7-run, make pf8-run, make pf10-run, make pf11-run, make pf12-run, make pf13-run, make pf14-run, make pf15-run"

.PHONY: migration-validate
migration-validate:
	@$(GRADLE) clean build
	@bash .aws/atx/skills/eap-primefaces-modernization/scripts/validate-modernized.sh
	@$(DOCKER_COMPOSE) config

.PHONY: eap8-pf15-run
eap8-pf15-run: pf15-run

.PHONY: eap8-pf15-assessment-run
eap8-pf15-assessment-run: pf15-assessment-run
