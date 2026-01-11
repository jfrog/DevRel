#!/usr/bin/env bash
set -euo pipefail

mkdir -p evidence

COMMIT_SHA="${GITHUB_SHA:-$(git rev-parse HEAD)}"
TS="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"

SBOM_SHA="$(sha256sum evidence/sbom.json | awk '{print $1}')"
POLICY_SHA="$(sha256sum evidence/policy-report.json | awk '{print $1}')"

cat > evidence/evidence.bundle.json <<EOF
{
  "commitSha": "${COMMIT_SHA}",
  "timestampUtc": "${TS}",
  "artifacts": {
    "sbom": { "path": "evidence/sbom.json", "sha256": "${SBOM_SHA}" },
    "policyReport": { "path": "evidence/policy-report.json", "sha256": "${POLICY_SHA}" }
  }
}
EOF

echo "[+] Evidence bundle created: evidence/evidence.bundle.json"
