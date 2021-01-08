.DEFAULT_GOAL:=help

.PHONY: help build run dry-run

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

run: ## Run the Ansible playbook
	ansible-playbook -i hosts -e @vars.yml setup-ubuntu.yml

dry-run: ## Run the Ansible playbook in a check mode
	@echo "YE BE WARNED: This will fail unless you comment our pre- and post- tasks from the setup-ubuntu.yml \n"
	ansible-playbook -i hosts -e @vars.yml setup-ubuntu.yml --check
