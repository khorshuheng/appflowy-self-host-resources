#!/bin/sh
docker run --rm --volume "$(pwd):/helm-docs" -u $(id -u) jnorwood/helm-docs:latest -s file
