REPO := jonpulsifer
IMAGE := tflab
TAG := webapp
FULL_IMAGE:=$(REPO)/$(IMAGE):$(TAG)

.PHONY: all
all: build-local

.PHONY: build-local
build-local:
	docker build -t $(IMAGE):$(TAG) .

release: build-local
	docker tag $(IMAGE):$(TAG) $(FULL_IMAGE)
	docker push $(FULL_IMAGE)

.PHONY: run
run:
	docker run --rm -e TFLAB_DEMO=true -p 8080:8080 $(IMAGE):$(TAG)
