IMAGE_NAME := python2-3-with-pi
BASE_IMAGE := python2-and-python3-in-docker

BUILD_DIR := build
DOCKER_REPO_DIR := $(BUILD_DIR)/DockersDir
BaseImageDir := $(DOCKER_REPO_DIR)/$(BASE_IMAGE)

build: base-image
	docker build -t $(IMAGE_NAME) .

base-image: $(DOCKER_REPO_DIR)
	docker build -t $(BASE_IMAGE) $(BaseImageDir)

$(DOCKER_REPO_DIR):
	mkdir -p $@
	git clone https://github.com/YanivRubin/DockerImages.git $@


.PHONY: build

