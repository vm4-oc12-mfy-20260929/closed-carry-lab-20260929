#!/usr/bin/env bash
set -euo pipefail

echo "vm4 current queue trust: skip-discard discriminator"

if [[ -f vm4-skip-discard-policy.txt ]]; then
  cat vm4-skip-discard-policy.txt
  if grep -qx 'unsafe=true' vm4-skip-discard-policy.txt; then
    echo "UNSAFE_STATE_DETECTED"
    exit 47
  fi
fi

echo "SAFE_STATE"
