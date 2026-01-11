#!/usr/bin/env bash
set -euo pipefail

mkdir -p evidence
echo "[+] Generating SBOM (CycloneDX)..."
npx @cyclonedx/cyclonedx-npm --output-file evidence/sbom.json
echo "[+] SBOM created: evidence/sbom.json"