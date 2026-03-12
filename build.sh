#!/usr/bin/env bash

set -euo pipefail

FILE_PATH="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

# Generate .env if not exists
if [[ ! -f "${FILE_PATH}/.env" ]]; then
    "${FILE_PATH}/setup.sh" --base-path "${FILE_PATH}"
fi

# Load .env
set -o allexport
# shellcheck disable=SC1091
source "${FILE_PATH}/.env"
set +o allexport

# Build target: devel (default), test, runtime
TARGET="${1:-devel}"

docker build -t "${DOCKER_HUB_USER}/${IMAGE_NAME}:${TARGET}" \
    --target="${TARGET}" \
    --build-arg USER="${USER_NAME}" \
    --build-arg GROUP="${USER_GROUP}" \
    --build-arg UID="${USER_UID}" \
    --build-arg GID="${USER_GID}" \
    --build-arg HARDWARE="${HARDWARE}" \
    -f "${FILE_PATH}/Dockerfile" "${FILE_PATH}"

#     --progress=plain \
#     --no-cache \
