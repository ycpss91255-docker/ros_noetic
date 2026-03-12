#!/usr/bin/env bash

# Get dependent parameters
FILE_PATH="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
# shellcheck disable=SC1091
source "${FILE_PATH}/get_param.sh"

# Run target: devel (default), runtime
# Usage: ./run.sh [target]
TARGET="${1:-devel}"

# shellcheck disable=SC2154
xhost "+SI:localuser:${user}" >/dev/null

# shellcheck disable=SC2154
# shellcheck disable=SC2086
docker run --rm \
    --privileged \
    --network=host \
    --ipc=host \
    --gpus all \
    -e DISPLAY="${DISPLAY}" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
    -v /dev:/dev \
    -v "${ws_path}":"/home/${user}/work" \
    -it --name "${container}" "${docker_hub_user}"/"${image}":"${TARGET}"
