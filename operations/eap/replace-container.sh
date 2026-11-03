#!/bin/bash
set -euo pipefail

if [[ ! "${EAP_APPLICATION_IMAGE:-}" =~ ^[^[:space:]@]+@sha256:[a-f0-9]{64}$ ]]; then
    printf 'EAP_APPLICATION_IMAGE must be a published application repository@sha256:<64 hex digits> reference\n' >&2
    exit 2
fi

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
docker pull --platform linux/amd64 "$EAP_APPLICATION_IMAGE"
docker compose --file "$root/docker-compose.production.yml" up \
    --detach --no-build --force-recreate --wait --wait-timeout 180
