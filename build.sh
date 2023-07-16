#!/bin/bash

DOCKER_IMAGE="${DOCKER_IMAGE:-php-dev}"

if [[ ! -d ./log ]]; then
  {
    mkdir -p ./log && chmod -R 777 ./log && touch ./log/.gitkeep
  } || exit 1
fi

exec docker build -t "${DOCKER_IMAGE}" .
