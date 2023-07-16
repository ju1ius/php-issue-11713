#!/bin/bash

DOCKER_IMAGE="${DOCKER_IMAGE:-php-dev}"

declare -a VALGRIND_OPTS=(
  --log-file=/app/log/valgrind.log
  --show-error-list=yes
  --keep-debuginfo=yes
  --leak-check=full
  --show-reachable=yes
  --track-origins=yes
  --num-callers=30
)

exec docker run -it --rm \
  --cap-add=SYS_PTRACE \
  --security-opt seccomp=unconfined \
  -v ./:/app/ \
  -e USE_ZEND_ALLOC=0 \
  -e ZEND_DONT_UNLOAD_MODULES=1 \
  "${DOCKER_IMAGE}" \
  valgrind --tool=memcheck "${VALGRIND_OPTS[@]}" \
  php /app/repro.php
