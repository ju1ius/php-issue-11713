#!/bin/bash

DOCKER_IMAGE="${DOCKER_IMAGE:-php-dev}"

exec docker run -it --rm \
  -v ./:/app/ \
  "${DOCKER_IMAGE}" \
  php /app/repro.php
