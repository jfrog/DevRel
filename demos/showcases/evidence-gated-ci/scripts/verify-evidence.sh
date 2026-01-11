#!/usr/bin/env bash
set -euo pipefail

if [ ! -f keys/public.pem ]; then
  echo "Missing keys/public.pem"
  exit 2
fi

openssl dgst -sha256 -verify keys/public.pem -signature evidence/evidence.bundle.sig evidence/evidence.bundle.json
echo "[+] Signature verified ✅"
