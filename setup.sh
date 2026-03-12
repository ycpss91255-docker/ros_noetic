#!/usr/bin/env bash
# Wrapper: delegates to docker_setup_helper/src/setup.sh
exec "$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)/docker_setup_helper/src/setup.sh" "$@"
