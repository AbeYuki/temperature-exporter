DOCKERFILE_PATH = .

IMAGE_NAME = temperature-exporter

VERSION = 1.1.0

REGISTRY = abeyuki

PLATFORMS = linux/amd64,linux/arm64,linux/ppc64le,linux/s390x,linux/arm/v7,linux/arm/v8

define RELEASE_NOTES
## metrics

```
# HELP cpu_temperature Temperature of the CPU
# TYPE cpu_temperature gauge
cpu_temperature{sensor="cpu_thermal"} 46.251
```

endef

export RELEASE_NOTES


build:
	docker build -t $(IMAGE_NAME):latest $(DOCKERFILE_PATH)
	docker build -t $(IMAGE_NAME):$(VERSION) $(DOCKERFILE_PATH)

push:
	docker buildx build --no-cache --platform $(PLATFORMS) -t $(REGISTRY)/$(IMAGE_NAME):latest --push $(DOCKERFILE_PATH)
	docker buildx build --no-cache --platform $(PLATFORMS) -t $(REGISTRY)/$(IMAGE_NAME):$(VERSION) --push $(DOCKERFILE_PATH)

release:
	git tag $(VERSION)
	git push origin $(VERSION)
	echo "$$RELEASE_NOTES" | gh release create $(VERSION) -t "$(VERSION)" -F -
