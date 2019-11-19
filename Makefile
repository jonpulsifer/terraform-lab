HOST := localhost
PORT := 8080
OS := $(shell uname -s)

.PHONY: all
all: help

.PHONY: deps
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
