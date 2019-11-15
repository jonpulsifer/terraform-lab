HOST := localhost
PORT := 8080
OS := $(shell uname -s)

.PHONY: all
all: help


.PHONY: go-deps
go-deps: ## installs go tools
	GO111MODULE="auto" go get -v golang.org/x/tools/cmd/present

.PHONY: present
present: ## presents the slideshow on $(HOST):$(PORT)
	present -orighost $(HOST) -http $(HOST):$(PORT) -notes

.PHONY: install-go
install-go: ## installs go using homebrew if OS=Darwin
ifeq ($(OS),Darwin)
	brew install go
endif

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | sed 's/^[^:]*://g' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
