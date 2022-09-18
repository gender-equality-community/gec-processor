IMG ?= ghcr.io/gender-equality-community/gec-processor
TAG ?= latest

.PHONY: docker-build docker-push
docker-build:
	docker build --label "tag=$(TAG)" --label "bom=https://github.com/gender-equality-community/gec-processor/releases/download/$(TAG)/bom.json" -t $(IMG):$(TAG) .

docker-push:
	docker push $(IMG):$(TAG)

.image:
	echo $(IMG):$(TAG) > $@
