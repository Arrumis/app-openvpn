#!/usr/bin/env bash
set -euo pipefail

ENV_FILE="${ENV_FILE:-.env.local}"

if [[ -f "${ENV_FILE}" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "${ENV_FILE}"
  set +a
fi

if [[ -z "${OPENVPN_ADMIN_PASSWORD:-}" ]]; then
  echo "OPENVPN_ADMIN_PASSWORD is not set."
  echo "Set it in ${ENV_FILE} or export it before running this script."
  exit 1
fi

CONTAINER_NAME="${CONTAINER_NAME:-$(docker compose ps -q openvpn-as)}"

if [[ -z "${CONTAINER_NAME}" ]]; then
  echo "OpenVPN container is not running."
  echo "Run: docker compose up -d"
  exit 1
fi

echo "Setting OpenVPN admin password..."
if docker exec "${CONTAINER_NAME}" sh -c "echo 'admin:${OPENVPN_ADMIN_PASSWORD}' | chpasswd"; then
  echo "Admin password updated."
else
  echo "Failed to update password automatically."
  echo "Run manually: docker exec -it ${CONTAINER_NAME} passwd admin"
  exit 1
fi

