VERSION := $(shell git describe --tags | sed -e 's/^v//g' | awk -F "-" '{print $$1}')

.PHONY:
tests:
	go test -coverprofile=coverage.out ./...

.PHONY:
show_cover:
	go tool cover -html=coverage.out

.PHONY:
linter:
	golangci-lint run

.PHONY:
clean_cache:
	go clean -cache

.PHONY:
build_binary:
	go build -ldflags="-X REPLACE_GIT_PATH/cmd/build.Version=$(VERSION)" -v -o REPLACEBINARY_NAME ./cmd

.PHONY:
docker_image:
	docker build --build-arg VERSION=$(VERSION) -t REPLACE_SERVICE_NAME:$(VERSION) -f docker/PATH_DOCKER_FILE .

.PHONY:
mockery:
	mockery --name $(name) --dir $(dir) --output $(dir)/mocks

