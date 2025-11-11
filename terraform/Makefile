.PHONY: init plan apply destroy fmt validate help

TF = terraform

help:
	@echo "Terraform workflow for Yandex Cloud"
	@echo ""
	@echo "Commands:"
	@echo "  make init      — initialize providers"
	@echo "  make fmt       — format code"
	@echo "  make validate  — check syntax"
	@echo "  make plan      — preview changes"
	@echo "  make apply     — apply (with confirmation)"
	@echo "  make apply-auto — apply without confirmation"
	@echo "  make destroy   — destroy all resources"

init:
	$(TF) init

fmt:
	$(TF) fmt -recursive

validate:
	$(TF) validate

plan:
	$(TF) plan

apply:
	$(TF) apply

apply-auto:
	$(TF) apply -auto-approve

destroy:
	$(TF) destroy