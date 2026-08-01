#!/usr/bin/env bash
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
ln -sfn "$DIR" ~/.dotfiles
sudo darwin-rebuild switch --flake ~/.dotfiles#mac

PI_PACKAGES=(
  "pi-web-access|npm:pi-web-access@0.14.0"
  "pi-openai-server-compaction|git:github.com/algal/pi-openai-server-compaction@c6d593087709e9481223dc6c6c2269b371b5e055"
)

if command -v pi >/dev/null 2>&1; then
  for package in "${PI_PACKAGES[@]}"; do
    package_name="${package%%|*}"
    package_source="${package#*|}"

    if pi list 2>/dev/null | rg -Fq "$package_name"; then
      echo "==> Pi package $package_name is already installed"
    else
      echo "==> Installing Pi package $package_name"
      if ! pi install "$package_source"; then
        echo "    Warning: Pi package installation failed. Run this manually when network access is available:"
        echo "    pi install $package_source"
      fi
    fi
  done
else
  echo "==> Pi is not available; skipping Pi package installation"
  echo "    Install Pi, then run ./rebuild.sh again"
fi
