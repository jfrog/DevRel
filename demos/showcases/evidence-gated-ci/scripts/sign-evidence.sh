#!/usr/bin/env bash
set -euo pipefail

if [ ! -f keys/private.pem ]; then
  echo "Missing keys/private.pem"
  exit 2
fi

openssl dgst -sha256 -sign keys/private.pem -out evidence/evidence.bundle.sig evidence/evidence.bundle.json
echo "[+] Signed: evidence/evidence.bundle.sig"
