#!/bin/bash

DOCKER_IMAGE="${DOCKER_IMAGE:-php-dev}"
VGCORE="$(find ./log -name 'valgrind.log.core.*' | sort -r | head -n1)"

if [[ -z "$VGCORE" ]]; then
  echo 'Valgrind coredump not found'
  exit 1
fi

exec docker run -it --rm \
  --cap-add=SYS_PTRACE \
  --security-opt seccomp=unconfined \
  -v ./:/app/ \
  "${DOCKER_IMAGE}" \
  gdb php "/app/${VGCORE}"
