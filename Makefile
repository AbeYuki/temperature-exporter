DOCKERFILE_PATH = .

IMAGE_NAME = temperature-exporter

VERSION = 1.0.0

REGISTRY = abeyuki

PLATFORMS = linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/arm/v7,linux/arm/v8

build:
	docker buildx build --platform $(PLATFORMS) -t $(REGISTRY)/$(IMAGE_NAME):latest --push $(DOCKERFILE_PATH)
	docker buildx build --platform $(PLATFORMS) -t $(REGISTRY)/$(IMAGE_NAME):$(VERSION) --push $(DOCKERFILE_PATH)
