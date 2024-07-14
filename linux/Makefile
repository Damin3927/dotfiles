.DEFAULT_GOAL := init


.PHONY: build_cli
build_cli: ## Build CLI
	cargo build --release

.PHONY: build_init
build_init: build_cli ## Build initialization files
	./target/release/dotfiles build-init


.PHONY: bootstrap
bootstrap: build_cli ## Bootstrap shell environments
	./target/release/dotfiles install-pkgs
	./bootstrap.sh


.PHONY: init
init: build_init bootstrap ## Initialize environments


.PHONY: help
help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
