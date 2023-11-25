DOCKERFILE_PATH = .

IMAGE_NAME = temperature-exporter

VERSION = 1.1.0

REGISTRY = abeyuki

PLATFORMS = linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/arm/v7,linux/arm/v8

build:
	docker build -t $(IMAGE_NAME):latest $(DOCKERFILE_PATH)
	docker build -t $(IMAGE_NAME):$(VERSION) $(DOCKERFILE_PATH)

push:
	docker buildx build --platform $(PLATFORMS) -t $(REGISTRY)/$(IMAGE_NAME):latest --push $(DOCKERFILE_PATH)
	docker buildx build --platform $(PLATFORMS) -t $(REGISTRY)/$(IMAGE_NAME):$(VERSION) --push $(DOCKERFILE_PATH)
