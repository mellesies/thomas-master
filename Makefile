# `make` is expected to be called from the directory that contains
# this Makefile

# IMAGE := "thomas"
TAG := latest

help:
	@echo "cat Makefile"

################################################################################
# Installation
################################################################################
uninstall:
	pip uninstall -y thomas-core
	pip uninstall -y thomas-jupyter-widget
	pip uninstall -y thomas-server
	pip uninstall -y thomas-client

install:
	cd thomas-core && pip install .
	cd thomas-jupyter-widget && pip install .
	cd thomas-server && pip install .
	cd thomas-client && pip install .

install-dev:
	cd thomas-core && pip install -e .
	cd thomas-jupyter-widget && pip install -e .
	cd thomas-server && pip install -e .
	cd thomas-client && pip install -e .


################################################################################
# PyPI & building/cleaning
################################################################################
publish-test:
	cd thomas-core && make publish-test
	cd thomas-jupyter-widget && make publish-test
	cd thomas-server && make publish-test
	cd thomas-client && make publish-test

publish:
	cd thomas-core && make publish
	cd thomas-jupyter-widget && make publish
	cd thomas-server && make publish
	cd thomas-client && make publish

clean:
	cd thomas-core && make clean
	cd thomas-jupyter-widget && make clean
	cd thomas-server && make clean
	cd thomas-client && make clean

################################################################################
# Docker
################################################################################
docker-images: docker-base-image docker-core-image docker-server-image

docker-base-image:
	# Build the base image
	docker build \
	  -f docker/thomas-base-python3.Dockerfile \
	  -t thomas-base-python3:${TAG} \
	  -t mellesies/thomas-base-python3:${TAG} \
	  ./

docker-core-image:
	# Build the core image
	docker build \
	  -f docker/thomas-core.Dockerfile \
	  -t thomas-core:${TAG} \
	  -t mellesies/thomas-core:${TAG} \
	  ./

docker-server-image:
	# --------------------------------------------------------------------------
	# Rebuild the UI
	# --------------------------------------------------------------------------
	cd thomas-ui-dev; npm run build && npm run deploy

	# --------------------------------------------------------------------------
	# Build the server image
	# --------------------------------------------------------------------------
	docker build \
	  -f docker/thomas-server.Dockerfile \
	  -t thomas-server:${TAG} \
	  -t mellesies/thomas-server:${TAG} \
	  ./

docker-push:
	docker push mellesies/thomas-base-python3:${TAG}
	docker push mellesies/thomas-core:${TAG}
	docker push mellesies/thomas-server:${TAG}


