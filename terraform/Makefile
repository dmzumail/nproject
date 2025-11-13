.PHONY: init plan apply destroy fmt validate output

TF = terraform

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

destroy:
	$(TF) destroy

output:
	@$(TF) output -json | jq -r '.website_url.value // "Run terraform apply first"'