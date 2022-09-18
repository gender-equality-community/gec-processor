IMG ?= ghcr.io/gender-equality-community/gec-processor
TAG ?= latest

.PHONY: docker-build docker-push
docker-build:
	docker build -t $(IMG):$(TAG) .

docker-push:
	docker push $(IMG):$(TAG)

.image:
	echo $(IMG):$(TAG) > $@
