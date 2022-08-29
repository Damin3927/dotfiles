.DEFAULT_GOAL: init


.PNOHY: build_init
build_init: ## Build initialization files
	go run ./cmd/build_init.go

.PNOHY: bootstrap
bootstrap: ## Bootstrap shell enviroments
	./bootstrap.sh

.PNOHY: init
init: build_init bootstrap ## Initialize environments


help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
