IMAGE_NAME := alexandrecarlton/atlassian-plugin-sdk
PLUGIN_SDK_VERSION := 6.3.12

VCS_REF := $(shell git rev-parse --short HEAD)

all: image

image: atlassian-plugin-sdk-image.tar
.PHONY: image

atlassian-plugin-sdk-image.tar: Dockerfile
	docker build \
		--build-arg PLUGIN_SDK_VERSION=$(PLUGIN_SDK_VERSION) \
		--label org.label-schema.build-date="$(shell date --rfc-3339=seconds)" \
		--label org.label-schema.name="atlassian-plugin-sdk" \
		--label org.label-schema.description="A docker image containing the Atlassian SDK" \
		--label org.label-schema.url="https://github.com/AlexandreCarlton/atlassian-plugin-sdk-docker" \
		--label org.label-schema.vcs-url="https://github.com/AlexandreCarlton/atlassian-plugin-sdk-docker" \
		--label org.label-schema.vcs-ref="$(VCS_REF)" \
		--label org.label-schema.version="$(PLUGIN_SDK_VERSION)" \
		--label org.label-schema.schema-version="1.0" \
		--tag $(IMAGE_NAME):build \
		.
	docker save --output="atlassian-plugin-sdk-image.tar" $(IMAGE_NAME):build

push: atlassian-plugin-sdk-image.tar
	docker load --input="atlassian-plugin-sdk-image.tar"
	docker tag $(IMAGE_NAME):build $(IMAGE_NAME):$(VCS_REF)
	docker tag $(IMAGE_NAME):build $(IMAGE_NAME):$(PLUGIN_SDK_VERSION)
	docker push $(IMAGE_NAME):$(VCS_REF)
	docker push $(IMAGE_NAME):$(PLUGIN_SDK_VERSION)
.PHONY: push
