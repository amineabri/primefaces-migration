#!/bin/bash
set -euo pipefail

management=http://127.0.0.1:9990

attribute_is() {
    local address=$1 name=$2 expected=$3 result
    result=$(/opt/server/bin/jboss-cli.sh --connect --timeout=8000 --output-json \
        --command="${address}:read-attribute(name=${name})")
    if ! grep -Eq "\"result\"[[:space:]]*:[[:space:]]*\"${expected}\"" <<< "$result"; then
        printf 'Unexpected %s/%s: %s\n' "$address" "$name" "$result" >&2
        return 1
    fi
}

startup() {
    attribute_is "" server-state running
    curl --noproxy '*' --fail --silent --show-error --max-time 5 "$management/health/ready" > /dev/null
}

case "${1:-readiness}" in
    startup)
        startup
        ;;
    liveness)
        curl --noproxy '*' --fail --silent --show-error --max-time 5 "$management/health/live" > /dev/null
        ;;
    readiness)
        startup
        attribute_is /deployment=ROOT.war status OK
        page=$(curl --noproxy '*' --fail --silent --show-error --max-time 5 http://127.0.0.1:8080/)
        if ! grep -Fq '<title>Home - PrimeFaces Home Office Sample</title>' <<< "$page"; then
            printf 'ROOT application home content is unavailable\n' >&2
            exit 1
        fi
        ;;
    *)
        printf 'Usage: %s {startup|liveness|readiness}\n' "$0" >&2
        exit 2
        ;;
esac
