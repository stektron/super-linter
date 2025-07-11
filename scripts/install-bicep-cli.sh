#!/usr/bin/env bash

set -euo pipefail

# Install Bicep CLI
# Requires curl and sudo
# Reference https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/linter

INSTALL_DIR="/usr/local/bin"
EXECUTABLE_PATH="${INSTALL_DIR}/bicep"

info() {
  echo -e "\e[32m[INFO] \e[0m$*\e[0m"
}

warning() {
  echo -e "\e[33m[WARN] \e[0m$*\e[0m"
}

error() {
  echo -e "\e[31m[ERROR] \e[0m$*\e[0m"
  exit 1
}

info "Starting Bicep CLI installation..."

arch=$(uname -m)
info "Detected architecture: ${arch}"

case "${arch}" in
x86_64)
  bicep_arch="x64"
  ;;
aarch64 | arm64)
  bicep_arch="arm64"
  ;;
*)
  error "Unsupported architecture: ${arch}. Only x86_64 and arm64 are supported."
  ;;
esac

download_url="https://github.com/Azure/bicep/releases/latest/download/bicep-linux-${bicep_arch}"

info "Downloading Bicep CLI for linux/${bicep_arch} from: ${download_url}"
curl -sSL -o ./bicep "${download_url}"

info "Setting execute permission for the Bicep binary..."
chmod +x ./bicep

info "Moving Bicep CLI to ${EXECUTABLE_PATH}..."
if command -v sudo >/dev/null 2>&1; then
  sudo mv ./bicep "${EXECUTABLE_PATH}"
else
  mv ./bicep "${EXECUTABLE_PATH}"
fi

info "Verifying the installation..."
bicep_cli_version=$("${EXECUTABLE_PATH}" --version)

info "Bicep CLI installed successfully!"
info "Version: ${bicep_cli_version}"
