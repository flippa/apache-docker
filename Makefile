PROJECT     ?= quay.io/flippa/apache
TAG         ?= 2.4.12
IMAGE       = $(PROJECT):$(TAG)
LATEST      = $(PROJECT):latest
DOCKEROPTS  ?=

build: Dockerfile
	docker build --rm -t $(IMAGE) .
	docker tag -f $(IMAGE) $(LATEST)

push:
	docker push $(IMAGE)
	docker push $(LATEST)
