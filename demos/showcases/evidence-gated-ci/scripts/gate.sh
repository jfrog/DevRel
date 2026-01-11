#!/usr/bin/env bash
set -euo pipefail

echo "[+] Running policy gate..."
node policies/typosquat-policy.js
echo "[+] Gate passed ✅"
