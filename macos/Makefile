.DEFAULT_GOAL := init

.PNONY: build_cli
build_cli:
	go build -o bin/dotfiles .

.PNOHY: build_init
build_init: build_cli ## Build initialization files
	./bin/dotfiles build-init

.PNOHY: bootstrap
bootstrap: build_cli ## Bootstrap shell environments
	./bin/dotfiles install-pkgs
	./bootstrap.sh

.PNOHY: init
init: build_init bootstrap ## Initialize environments


.PNOHY: help
help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
