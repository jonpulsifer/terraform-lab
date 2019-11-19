REPO:=jonpulsifer
IMAGE:=tflab
TAG:=sudo
FULL_IMAGE:=$(REPO)/$(IMAGE):$(TAG)

.PHONY: all
all: build

.PHONY: build
build:
	docker build -t $(IMAGE):$(TAG) .

.PHONY: release
release: build
	docker tag $(IMAGE):$(TAG) $(FULL_IMAGE)
	docker push $(FULL_IMAGE)
