#!/usr/bin/env bash
set -euo pipefail

mkdir -p evidence
echo "[+] Generating SBOM (CycloneDX)..."
cd app
npx @cyclonedx/cyclonedx-npm --output-file ../evidence/sbom.json
cd ..
echo "[+] SBOM created: evidence/sbom.json"