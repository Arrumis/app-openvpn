#!/usr/bin/env bash
set -euo pipefail

if [[ -f ".env.local" ]]; then
  set -a
  # shellcheck disable=SC1091
  source ".env.local"
  set +a
fi

DATA_DIR="${1:-${HOST_DATA_DIR:-./data}}"
CONFIG_DIR="${OPENVPN_CONFIG_DIR:-${DATA_DIR}}"

mkdir -p "${CONFIG_DIR}"

echo "Initialized OpenVPN data directories under: ${DATA_DIR}"
