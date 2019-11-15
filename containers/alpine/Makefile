REPO:=jonpulsifer
IMAGE:=alpine
TAG:=tflab
FULL_IMAGE:=$(REPO)/$(IMAGE):$(TAG)

.PHONY: all
all: build

.PHONY: build
build:
	docker build -t $(FULL_IMAGE) .

.PHONY: release
release: build
	docker push $(FULL_IMAGE)
